
gcc_vector_compare_ops.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<main>:
               	subq	$0x178, %rsp            # imm = 0x178
               	leaq	(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x10(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x20(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x30(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x40(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x50(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x60(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x70(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x80(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x90(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xa0(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xb0(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xc0(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xd0(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xe0(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xf0(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x148(%rsp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	0x150(%rsp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movups	(%rsp), %xmm0
               	vpcmpeqb	%xmm0, %xmm0, %xmm0
               	movups	%xmm0, 0x100(%rsp)
               	xorl	%eax, %eax
               	movsbq	0x100(%rsp,%rax), %rdx
               	cmpl	$-0x1, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movabsq	$0xff0000ff0000ff, %rax # imm = 0xFF0000FF0000FF
               	movq	%rax, %xmm14
               	vpextrb	$0x0, %xmm14, %ecx
               	movsbq	%cl, %rcx
               	cmpq	$-0x1, %rcx
               	jne	<addr>
               	movq	%rax, %xmm14
               	vpextrb	$0x1, %xmm14, %eax
               	movsbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x178, %rsp            # imm = 0x178
               	retq
               	movups	(%rsp), %xmm0
               	movups	0x10(%rsp), %xmm1
               	vpcmpeqb	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x100(%rsp)
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	movzbq	0x10(%rsp,%rax), %r8
               	movq	$-0x1, %r9
               	movzbq	(%rsp,%rax), %r10
               	cmpl	%r8d, %r10d
               	cmovneq	%rcx, %r9
               	movb	%r9b, 0x160(%rsp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x100(%rsp,%rax), %rsi
               	movzbq	0x160(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x100(%rsp), %rdx
               	movzbq	(%rsp), %rax
               	movzbq	0x10(%rsp), %rsi
               	cmpl	%esi, %eax
               	setne	%sil
               	movzbq	%sil, %rsi
               	xorl	%eax, %eax
               	negq	%rsi
               	movb	%sil, 0x100(%rsp)
               	movzbq	0x1(%rsp), %rsi
               	movzbq	0x11(%rsp), %rdi
               	cmpl	%edi, %esi
               	setne	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x101(%rsp)
               	movzbq	0x2(%rsp), %rsi
               	movzbq	0x12(%rsp), %rdi
               	cmpl	%edi, %esi
               	setne	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x102(%rsp)
               	movzbq	0x3(%rsp), %rsi
               	movzbq	0x13(%rsp), %rdi
               	cmpl	%edi, %esi
               	setne	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x103(%rsp)
               	movzbq	0x4(%rsp), %rsi
               	movzbq	0x14(%rsp), %rdi
               	cmpl	%edi, %esi
               	setne	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x104(%rsp)
               	movzbq	0x5(%rsp), %rsi
               	movzbq	0x15(%rsp), %rdi
               	cmpl	%edi, %esi
               	setne	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x105(%rsp)
               	movzbq	0x6(%rsp), %rsi
               	movzbq	0x16(%rsp), %rdi
               	cmpl	%edi, %esi
               	setne	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x106(%rsp)
               	movzbq	0x7(%rsp), %rsi
               	movzbq	0x17(%rsp), %rdi
               	cmpl	%edi, %esi
               	setne	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x107(%rsp)
               	movzbq	0x8(%rsp), %rsi
               	movzbq	0x18(%rsp), %rdi
               	cmpl	%edi, %esi
               	setne	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x108(%rsp)
               	movzbq	0x9(%rsp), %rsi
               	movzbq	0x19(%rsp), %rdi
               	cmpl	%edi, %esi
               	setne	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x109(%rsp)
               	movzbq	0xa(%rsp), %rsi
               	movzbq	0x1a(%rsp), %rdi
               	cmpl	%edi, %esi
               	setne	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x10a(%rsp)
               	movzbq	0xb(%rsp), %rsi
               	movzbq	0x1b(%rsp), %rdi
               	cmpl	%edi, %esi
               	setne	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x10b(%rsp)
               	movzbq	0xc(%rsp), %rsi
               	movzbq	0x1c(%rsp), %rdi
               	cmpl	%edi, %esi
               	setne	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x10c(%rsp)
               	movzbq	0xd(%rsp), %rsi
               	movzbq	0x1d(%rsp), %rdi
               	cmpl	%edi, %esi
               	setne	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x10d(%rsp)
               	movzbq	0xe(%rsp), %rsi
               	movzbq	0x1e(%rsp), %rdi
               	cmpl	%edi, %esi
               	setne	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x10e(%rsp)
               	movzbq	0xf(%rsp), %rsi
               	movzbq	0x1f(%rsp), %rdi
               	cmpl	%edi, %esi
               	setne	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x10f(%rsp)
               	leaq	0x110(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movzbq	0x10(%rsp,%rax), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movzbq	(%rsp,%rax), %r8
               	cmpl	%edx, %r8d
               	cmoveq	%rdi, %rsi
               	movb	%sil, 0x160(%rsp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x110(%rsp,%rax), %rsi
               	movzbq	0x160(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x100(%rsp), %rdx
               	movzbq	(%rsp), %rax
               	movzbq	0x10(%rsp), %rsi
               	cmpl	%esi, %eax
               	setb	%sil
               	movzbq	%sil, %rsi
               	xorl	%eax, %eax
               	negq	%rsi
               	movb	%sil, 0x100(%rsp)
               	movzbq	0x1(%rsp), %rsi
               	movzbq	0x11(%rsp), %rdi
               	cmpl	%edi, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x101(%rsp)
               	movzbq	0x2(%rsp), %rsi
               	movzbq	0x12(%rsp), %rdi
               	cmpl	%edi, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x102(%rsp)
               	movzbq	0x3(%rsp), %rsi
               	movzbq	0x13(%rsp), %rdi
               	cmpl	%edi, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x103(%rsp)
               	movzbq	0x4(%rsp), %rsi
               	movzbq	0x14(%rsp), %rdi
               	cmpl	%edi, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x104(%rsp)
               	movzbq	0x5(%rsp), %rsi
               	movzbq	0x15(%rsp), %rdi
               	cmpl	%edi, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x105(%rsp)
               	movzbq	0x6(%rsp), %rsi
               	movzbq	0x16(%rsp), %rdi
               	cmpl	%edi, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x106(%rsp)
               	movzbq	0x7(%rsp), %rsi
               	movzbq	0x17(%rsp), %rdi
               	cmpl	%edi, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x107(%rsp)
               	movzbq	0x8(%rsp), %rsi
               	movzbq	0x18(%rsp), %rdi
               	cmpl	%edi, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x108(%rsp)
               	movzbq	0x9(%rsp), %rsi
               	movzbq	0x19(%rsp), %rdi
               	cmpl	%edi, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x109(%rsp)
               	movzbq	0xa(%rsp), %rsi
               	movzbq	0x1a(%rsp), %rdi
               	cmpl	%edi, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x10a(%rsp)
               	movzbq	0xb(%rsp), %rsi
               	movzbq	0x1b(%rsp), %rdi
               	cmpl	%edi, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x10b(%rsp)
               	movzbq	0xc(%rsp), %rsi
               	movzbq	0x1c(%rsp), %rdi
               	cmpl	%edi, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x10c(%rsp)
               	movzbq	0xd(%rsp), %rsi
               	movzbq	0x1d(%rsp), %rdi
               	cmpl	%edi, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x10d(%rsp)
               	movzbq	0xe(%rsp), %rsi
               	movzbq	0x1e(%rsp), %rdi
               	cmpl	%edi, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x10e(%rsp)
               	movzbq	0xf(%rsp), %rsi
               	movzbq	0x1f(%rsp), %rdi
               	cmpl	%edi, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x10f(%rsp)
               	leaq	0x110(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movzbq	0x10(%rsp,%rax), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movzbq	(%rsp,%rax), %r8
               	cmpl	%edx, %r8d
               	cmovgeq	%rdi, %rsi
               	movb	%sil, 0x160(%rsp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x110(%rsp,%rax), %rsi
               	movzbq	0x160(%rsp,%rax), %rdi
               	nopl	(%rax,%rax)
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x100(%rsp), %rdx
               	movzbq	(%rsp), %rax
               	movzbq	0x10(%rsp), %rsi
               	cmpl	%esi, %eax
               	setbe	%sil
               	movzbq	%sil, %rsi
               	xorl	%eax, %eax
               	negq	%rsi
               	movb	%sil, 0x100(%rsp)
               	movzbq	0x1(%rsp), %rsi
               	movzbq	0x11(%rsp), %rdi
               	cmpl	%edi, %esi
               	setbe	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x101(%rsp)
               	movzbq	0x2(%rsp), %rsi
               	movzbq	0x12(%rsp), %rdi
               	cmpl	%edi, %esi
               	setbe	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x102(%rsp)
               	movzbq	0x3(%rsp), %rsi
               	movzbq	0x13(%rsp), %rdi
               	cmpl	%edi, %esi
               	setbe	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x103(%rsp)
               	movzbq	0x4(%rsp), %rsi
               	movzbq	0x14(%rsp), %rdi
               	cmpl	%edi, %esi
               	setbe	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x104(%rsp)
               	movzbq	0x5(%rsp), %rsi
               	movzbq	0x15(%rsp), %rdi
               	cmpl	%edi, %esi
               	setbe	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x105(%rsp)
               	movzbq	0x6(%rsp), %rsi
               	movzbq	0x16(%rsp), %rdi
               	cmpl	%edi, %esi
               	setbe	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x106(%rsp)
               	movzbq	0x7(%rsp), %rsi
               	movzbq	0x17(%rsp), %rdi
               	cmpl	%edi, %esi
               	setbe	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x107(%rsp)
               	movzbq	0x8(%rsp), %rsi
               	movzbq	0x18(%rsp), %rdi
               	cmpl	%edi, %esi
               	setbe	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x108(%rsp)
               	movzbq	0x9(%rsp), %rsi
               	movzbq	0x19(%rsp), %rdi
               	cmpl	%edi, %esi
               	setbe	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x109(%rsp)
               	movzbq	0xa(%rsp), %rsi
               	movzbq	0x1a(%rsp), %rdi
               	cmpl	%edi, %esi
               	setbe	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x10a(%rsp)
               	movzbq	0xb(%rsp), %rsi
               	movzbq	0x1b(%rsp), %rdi
               	cmpl	%edi, %esi
               	setbe	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x10b(%rsp)
               	movzbq	0xc(%rsp), %rsi
               	movzbq	0x1c(%rsp), %rdi
               	cmpl	%edi, %esi
               	setbe	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x10c(%rsp)
               	movzbq	0xd(%rsp), %rsi
               	movzbq	0x1d(%rsp), %rdi
               	cmpl	%edi, %esi
               	setbe	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x10d(%rsp)
               	movzbq	0xe(%rsp), %rsi
               	movzbq	0x1e(%rsp), %rdi
               	cmpl	%edi, %esi
               	setbe	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x10e(%rsp)
               	movzbq	0xf(%rsp), %rsi
               	movzbq	0x1f(%rsp), %rdi
               	cmpl	%edi, %esi
               	setbe	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x10f(%rsp)
               	leaq	0x110(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movzbq	0x10(%rsp,%rax), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movzbq	(%rsp,%rax), %r8
               	cmpl	%edx, %r8d
               	cmovgq	%rdi, %rsi
               	movb	%sil, 0x160(%rsp,%rax)
               	incq	%rax
               	nop
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x110(%rsp,%rax), %rsi
               	movzbq	0x160(%rsp,%rax), %rdi
               	nopl	(%rax)
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x100(%rsp), %rdx
               	movzbq	(%rsp), %rax
               	movzbq	0x10(%rsp), %rsi
               	cmpl	%esi, %eax
               	seta	%sil
               	movzbq	%sil, %rsi
               	xorl	%eax, %eax
               	negq	%rsi
               	movb	%sil, 0x100(%rsp)
               	movzbq	0x1(%rsp), %rsi
               	movzbq	0x11(%rsp), %rdi
               	cmpl	%edi, %esi
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x101(%rsp)
               	movzbq	0x2(%rsp), %rsi
               	movzbq	0x12(%rsp), %rdi
               	cmpl	%edi, %esi
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x102(%rsp)
               	movzbq	0x3(%rsp), %rsi
               	movzbq	0x13(%rsp), %rdi
               	cmpl	%edi, %esi
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x103(%rsp)
               	movzbq	0x4(%rsp), %rsi
               	movzbq	0x14(%rsp), %rdi
               	cmpl	%edi, %esi
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x104(%rsp)
               	movzbq	0x5(%rsp), %rsi
               	movzbq	0x15(%rsp), %rdi
               	cmpl	%edi, %esi
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x105(%rsp)
               	movzbq	0x6(%rsp), %rsi
               	movzbq	0x16(%rsp), %rdi
               	cmpl	%edi, %esi
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x106(%rsp)
               	movzbq	0x7(%rsp), %rsi
               	movzbq	0x17(%rsp), %rdi
               	cmpl	%edi, %esi
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x107(%rsp)
               	movzbq	0x8(%rsp), %rsi
               	movzbq	0x18(%rsp), %rdi
               	cmpl	%edi, %esi
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x108(%rsp)
               	movzbq	0x9(%rsp), %rsi
               	movzbq	0x19(%rsp), %rdi
               	cmpl	%edi, %esi
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x109(%rsp)
               	movzbq	0xa(%rsp), %rsi
               	movzbq	0x1a(%rsp), %rdi
               	cmpl	%edi, %esi
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x10a(%rsp)
               	movzbq	0xb(%rsp), %rsi
               	movzbq	0x1b(%rsp), %rdi
               	cmpl	%edi, %esi
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x10b(%rsp)
               	movzbq	0xc(%rsp), %rsi
               	movzbq	0x1c(%rsp), %rdi
               	cmpl	%edi, %esi
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x10c(%rsp)
               	movzbq	0xd(%rsp), %rsi
               	movzbq	0x1d(%rsp), %rdi
               	cmpl	%edi, %esi
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x10d(%rsp)
               	movzbq	0xe(%rsp), %rsi
               	movzbq	0x1e(%rsp), %rdi
               	cmpl	%edi, %esi
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x10e(%rsp)
               	movzbq	0xf(%rsp), %rsi
               	movzbq	0x1f(%rsp), %rdi
               	cmpl	%edi, %esi
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x10f(%rsp)
               	leaq	0x110(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movzbq	0x10(%rsp,%rax), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movzbq	(%rsp,%rax), %r8
               	cmpl	%edx, %r8d
               	cmovleq	%rdi, %rsi
               	movb	%sil, 0x160(%rsp,%rax)
               	incq	%rax
               	nop
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x110(%rsp,%rax), %rsi
               	movzbq	0x160(%rsp,%rax), %rdi
               	nopl	(%rax)
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x100(%rsp), %rdx
               	movzbq	(%rsp), %rax
               	movzbq	0x10(%rsp), %rsi
               	cmpl	%esi, %eax
               	setae	%sil
               	movzbq	%sil, %rsi
               	xorl	%eax, %eax
               	negq	%rsi
               	movb	%sil, 0x100(%rsp)
               	movzbq	0x1(%rsp), %rsi
               	movzbq	0x11(%rsp), %rdi
               	cmpl	%edi, %esi
               	setae	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x101(%rsp)
               	movzbq	0x2(%rsp), %rsi
               	movzbq	0x12(%rsp), %rdi
               	cmpl	%edi, %esi
               	setae	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x102(%rsp)
               	movzbq	0x3(%rsp), %rsi
               	movzbq	0x13(%rsp), %rdi
               	cmpl	%edi, %esi
               	setae	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x103(%rsp)
               	movzbq	0x4(%rsp), %rsi
               	movzbq	0x14(%rsp), %rdi
               	cmpl	%edi, %esi
               	setae	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x104(%rsp)
               	movzbq	0x5(%rsp), %rsi
               	movzbq	0x15(%rsp), %rdi
               	cmpl	%edi, %esi
               	setae	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x105(%rsp)
               	movzbq	0x6(%rsp), %rsi
               	movzbq	0x16(%rsp), %rdi
               	cmpl	%edi, %esi
               	setae	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x106(%rsp)
               	movzbq	0x7(%rsp), %rsi
               	movzbq	0x17(%rsp), %rdi
               	cmpl	%edi, %esi
               	setae	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x107(%rsp)
               	movzbq	0x8(%rsp), %rsi
               	movzbq	0x18(%rsp), %rdi
               	cmpl	%edi, %esi
               	setae	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x108(%rsp)
               	movzbq	0x9(%rsp), %rsi
               	movzbq	0x19(%rsp), %rdi
               	cmpl	%edi, %esi
               	setae	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x109(%rsp)
               	movzbq	0xa(%rsp), %rsi
               	movzbq	0x1a(%rsp), %rdi
               	cmpl	%edi, %esi
               	setae	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x10a(%rsp)
               	movzbq	0xb(%rsp), %rsi
               	movzbq	0x1b(%rsp), %rdi
               	cmpl	%edi, %esi
               	setae	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x10b(%rsp)
               	movzbq	0xc(%rsp), %rsi
               	movzbq	0x1c(%rsp), %rdi
               	cmpl	%edi, %esi
               	setae	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x10c(%rsp)
               	movzbq	0xd(%rsp), %rsi
               	movzbq	0x1d(%rsp), %rdi
               	cmpl	%edi, %esi
               	setae	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x10d(%rsp)
               	movzbq	0xe(%rsp), %rsi
               	movzbq	0x1e(%rsp), %rdi
               	cmpl	%edi, %esi
               	setae	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x10e(%rsp)
               	movzbq	0xf(%rsp), %rsi
               	movzbq	0x1f(%rsp), %rdi
               	cmpl	%edi, %esi
               	setae	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x10f(%rsp)
               	leaq	0x110(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movzbq	0x10(%rsp,%rax), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movzbq	(%rsp,%rax), %r8
               	cmpl	%edx, %r8d
               	cmovlq	%rdi, %rsi
               	movb	%sil, 0x160(%rsp,%rax)
               	incq	%rax
               	nop
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x110(%rsp,%rax), %rsi
               	movzbq	0x160(%rsp,%rax), %rdi
               	nopl	(%rax)
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	0x20(%rsp), %xmm0
               	movups	0x30(%rsp), %xmm1
               	vpcmpeqb	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x100(%rsp)
               	xorl	%eax, %eax
               	movsbq	0x30(%rsp,%rax), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movsbq	0x20(%rsp,%rax), %r8
               	cmpl	%edx, %r8d
               	cmovneq	%rdi, %rsi
               	movb	%sil, 0x160(%rsp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x100(%rsp,%rax), %rsi
               	movzbq	0x160(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x100(%rsp), %rdx
               	movsbq	0x20(%rsp), %rax
               	movsbq	0x30(%rsp), %rsi
               	cmpl	%esi, %eax
               	setne	%sil
               	movzbq	%sil, %rsi
               	xorl	%eax, %eax
               	negq	%rsi
               	movb	%sil, 0x100(%rsp)
               	movsbq	0x21(%rsp), %rsi
               	movsbq	0x31(%rsp), %rdi
               	cmpl	%edi, %esi
               	setne	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x101(%rsp)
               	movsbq	0x22(%rsp), %rsi
               	movsbq	0x32(%rsp), %rdi
               	cmpl	%edi, %esi
               	setne	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x102(%rsp)
               	movsbq	0x23(%rsp), %rsi
               	movsbq	0x33(%rsp), %rdi
               	cmpl	%edi, %esi
               	setne	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x103(%rsp)
               	movsbq	0x24(%rsp), %rsi
               	movsbq	0x34(%rsp), %rdi
               	cmpl	%edi, %esi
               	setne	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x104(%rsp)
               	movsbq	0x25(%rsp), %rsi
               	movsbq	0x35(%rsp), %rdi
               	cmpl	%edi, %esi
               	setne	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x105(%rsp)
               	movsbq	0x26(%rsp), %rsi
               	movsbq	0x36(%rsp), %rdi
               	cmpl	%edi, %esi
               	setne	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x106(%rsp)
               	movsbq	0x27(%rsp), %rsi
               	movsbq	0x37(%rsp), %rdi
               	cmpl	%edi, %esi
               	setne	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x107(%rsp)
               	movsbq	0x28(%rsp), %rsi
               	movsbq	0x38(%rsp), %rdi
               	cmpl	%edi, %esi
               	setne	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x108(%rsp)
               	movsbq	0x29(%rsp), %rsi
               	movsbq	0x39(%rsp), %rdi
               	cmpl	%edi, %esi
               	setne	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x109(%rsp)
               	movsbq	0x2a(%rsp), %rsi
               	movsbq	0x3a(%rsp), %rdi
               	cmpl	%edi, %esi
               	setne	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x10a(%rsp)
               	movsbq	0x2b(%rsp), %rsi
               	movsbq	0x3b(%rsp), %rdi
               	cmpl	%edi, %esi
               	setne	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x10b(%rsp)
               	movsbq	0x2c(%rsp), %rsi
               	movsbq	0x3c(%rsp), %rdi
               	cmpl	%edi, %esi
               	setne	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x10c(%rsp)
               	movsbq	0x2d(%rsp), %rsi
               	movsbq	0x3d(%rsp), %rdi
               	cmpl	%edi, %esi
               	setne	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x10d(%rsp)
               	movsbq	0x2e(%rsp), %rsi
               	movsbq	0x3e(%rsp), %rdi
               	cmpl	%edi, %esi
               	setne	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x10e(%rsp)
               	movsbq	0x2f(%rsp), %rsi
               	movsbq	0x3f(%rsp), %rdi
               	cmpl	%edi, %esi
               	setne	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x10f(%rsp)
               	leaq	0x110(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movsbq	0x30(%rsp,%rax), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movsbq	0x20(%rsp,%rax), %r8
               	cmpl	%edx, %r8d
               	cmoveq	%rdi, %rsi
               	movb	%sil, 0x160(%rsp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x110(%rsp,%rax), %rsi
               	movzbq	0x160(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	0x30(%rsp), %xmm0
               	movups	0x20(%rsp), %xmm1
               	vpcmpgtb	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x100(%rsp)
               	xorl	%eax, %eax
               	movsbq	0x30(%rsp,%rax), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movsbq	0x20(%rsp,%rax), %r8
               	cmpl	%edx, %r8d
               	cmovgeq	%rdi, %rsi
               	movb	%sil, 0x160(%rsp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x100(%rsp,%rax), %rsi
               	movzbq	0x160(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x100(%rsp), %rdx
               	movsbq	0x20(%rsp), %rax
               	movsbq	0x30(%rsp), %rsi
               	cmpl	%esi, %eax
               	setle	%sil
               	movzbq	%sil, %rsi
               	xorl	%eax, %eax
               	negq	%rsi
               	movb	%sil, 0x100(%rsp)
               	movsbq	0x21(%rsp), %rsi
               	movsbq	0x31(%rsp), %rdi
               	cmpl	%edi, %esi
               	setle	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x101(%rsp)
               	movsbq	0x22(%rsp), %rsi
               	movsbq	0x32(%rsp), %rdi
               	cmpl	%edi, %esi
               	setle	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x102(%rsp)
               	movsbq	0x23(%rsp), %rsi
               	movsbq	0x33(%rsp), %rdi
               	cmpl	%edi, %esi
               	setle	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x103(%rsp)
               	movsbq	0x24(%rsp), %rsi
               	movsbq	0x34(%rsp), %rdi
               	cmpl	%edi, %esi
               	setle	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x104(%rsp)
               	movsbq	0x25(%rsp), %rsi
               	movsbq	0x35(%rsp), %rdi
               	cmpl	%edi, %esi
               	setle	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x105(%rsp)
               	movsbq	0x26(%rsp), %rsi
               	movsbq	0x36(%rsp), %rdi
               	cmpl	%edi, %esi
               	setle	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x106(%rsp)
               	movsbq	0x27(%rsp), %rsi
               	movsbq	0x37(%rsp), %rdi
               	cmpl	%edi, %esi
               	setle	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x107(%rsp)
               	movsbq	0x28(%rsp), %rsi
               	movsbq	0x38(%rsp), %rdi
               	cmpl	%edi, %esi
               	setle	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x108(%rsp)
               	movsbq	0x29(%rsp), %rsi
               	movsbq	0x39(%rsp), %rdi
               	cmpl	%edi, %esi
               	setle	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x109(%rsp)
               	movsbq	0x2a(%rsp), %rsi
               	movsbq	0x3a(%rsp), %rdi
               	cmpl	%edi, %esi
               	setle	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x10a(%rsp)
               	movsbq	0x2b(%rsp), %rsi
               	movsbq	0x3b(%rsp), %rdi
               	cmpl	%edi, %esi
               	setle	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x10b(%rsp)
               	movsbq	0x2c(%rsp), %rsi
               	movsbq	0x3c(%rsp), %rdi
               	cmpl	%edi, %esi
               	setle	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x10c(%rsp)
               	movsbq	0x2d(%rsp), %rsi
               	movsbq	0x3d(%rsp), %rdi
               	cmpl	%edi, %esi
               	setle	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x10d(%rsp)
               	movsbq	0x2e(%rsp), %rsi
               	movsbq	0x3e(%rsp), %rdi
               	cmpl	%edi, %esi
               	setle	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x10e(%rsp)
               	movsbq	0x2f(%rsp), %rsi
               	movsbq	0x3f(%rsp), %rdi
               	cmpl	%edi, %esi
               	setle	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x10f(%rsp)
               	leaq	0x110(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movsbq	0x30(%rsp,%rax), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movsbq	0x20(%rsp,%rax), %r8
               	cmpl	%edx, %r8d
               	cmovgq	%rdi, %rsi
               	movb	%sil, 0x160(%rsp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x110(%rsp,%rax), %rsi
               	movzbq	0x160(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	0x20(%rsp), %xmm0
               	movups	0x30(%rsp), %xmm1
               	vpcmpgtb	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x100(%rsp)
               	xorl	%eax, %eax
               	movsbq	0x30(%rsp,%rax), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movsbq	0x20(%rsp,%rax), %r8
               	cmpl	%edx, %r8d
               	cmovleq	%rdi, %rsi
               	movb	%sil, 0x160(%rsp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x100(%rsp,%rax), %rsi
               	movzbq	0x160(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	nopw	(%rax,%rax)
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x100(%rsp), %rdx
               	movsbq	0x20(%rsp), %rax
               	movsbq	0x30(%rsp), %rsi
               	cmpl	%esi, %eax
               	setge	%sil
               	movzbq	%sil, %rsi
               	xorl	%eax, %eax
               	negq	%rsi
               	movb	%sil, 0x100(%rsp)
               	movsbq	0x21(%rsp), %rsi
               	movsbq	0x31(%rsp), %rdi
               	cmpl	%edi, %esi
               	setge	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x101(%rsp)
               	movsbq	0x22(%rsp), %rsi
               	movsbq	0x32(%rsp), %rdi
               	cmpl	%edi, %esi
               	setge	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x102(%rsp)
               	movsbq	0x23(%rsp), %rsi
               	movsbq	0x33(%rsp), %rdi
               	cmpl	%edi, %esi
               	setge	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x103(%rsp)
               	movsbq	0x24(%rsp), %rsi
               	movsbq	0x34(%rsp), %rdi
               	cmpl	%edi, %esi
               	setge	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x104(%rsp)
               	movsbq	0x25(%rsp), %rsi
               	movsbq	0x35(%rsp), %rdi
               	cmpl	%edi, %esi
               	setge	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x105(%rsp)
               	movsbq	0x26(%rsp), %rsi
               	movsbq	0x36(%rsp), %rdi
               	cmpl	%edi, %esi
               	setge	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x106(%rsp)
               	movsbq	0x27(%rsp), %rsi
               	movsbq	0x37(%rsp), %rdi
               	cmpl	%edi, %esi
               	setge	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x107(%rsp)
               	movsbq	0x28(%rsp), %rsi
               	movsbq	0x38(%rsp), %rdi
               	cmpl	%edi, %esi
               	setge	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x108(%rsp)
               	movsbq	0x29(%rsp), %rsi
               	movsbq	0x39(%rsp), %rdi
               	cmpl	%edi, %esi
               	setge	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x109(%rsp)
               	movsbq	0x2a(%rsp), %rsi
               	movsbq	0x3a(%rsp), %rdi
               	cmpl	%edi, %esi
               	setge	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x10a(%rsp)
               	movsbq	0x2b(%rsp), %rsi
               	movsbq	0x3b(%rsp), %rdi
               	cmpl	%edi, %esi
               	setge	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x10b(%rsp)
               	movsbq	0x2c(%rsp), %rsi
               	movsbq	0x3c(%rsp), %rdi
               	cmpl	%edi, %esi
               	setge	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x10c(%rsp)
               	movsbq	0x2d(%rsp), %rsi
               	movsbq	0x3d(%rsp), %rdi
               	cmpl	%edi, %esi
               	setge	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x10d(%rsp)
               	movsbq	0x2e(%rsp), %rsi
               	movsbq	0x3e(%rsp), %rdi
               	cmpl	%edi, %esi
               	setge	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x10e(%rsp)
               	movsbq	0x2f(%rsp), %rsi
               	movsbq	0x3f(%rsp), %rdi
               	cmpl	%edi, %esi
               	setge	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x10f(%rsp)
               	leaq	0x110(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movsbq	0x30(%rsp,%rax), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movsbq	0x20(%rsp,%rax), %r8
               	cmpl	%edx, %r8d
               	cmovlq	%rdi, %rsi
               	movb	%sil, 0x160(%rsp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x110(%rsp,%rax), %rsi
               	movzbq	0x160(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	nopw	(%rax,%rax)
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	0x40(%rsp), %xmm0
               	movups	0x50(%rsp), %xmm1
               	vpcmpeqw	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x100(%rsp)
               	xorl	%eax, %eax
               	movzwq	0x50(%rsp,%rax,2), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movzwq	0x40(%rsp,%rax,2), %r8
               	cmpl	%edx, %r8d
               	cmovneq	%rdi, %rsi
               	movw	%si, 0x160(%rsp,%rax,2)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x100(%rsp,%rax), %rsi
               	movzbq	0x160(%rsp,%rax), %rdi
               	nopl	(%rax)
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movzwq	0x40(%rsp), %rax
               	movzwq	0x50(%rsp), %rcx
               	cmpl	%ecx, %eax
               	setb	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	negq	%rcx
               	movzwq	0x42(%rsp), %rdx
               	movzwq	0x52(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movzwq	0x44(%rsp), %rsi
               	movzwq	0x54(%rsp), %rdi
               	cmpl	%edi, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movzwq	0x46(%rsp), %rdi
               	movzwq	0x56(%rsp), %r8
               	cmpl	%r8d, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movzwq	0x48(%rsp), %r8
               	movzwq	0x58(%rsp), %r9
               	cmpl	%r9d, %r8d
               	setb	%r8b
               	movzbq	%r8b, %r8
               	negq	%r8
               	movzwq	0x4a(%rsp), %r9
               	movzwq	0x5a(%rsp), %r10
               	cmpl	%r10d, %r9d
               	setb	%r9b
               	movzbq	%r9b, %r9
               	negq	%r9
               	movzwq	0x4c(%rsp), %r10
               	movzwq	0x5c(%rsp), %r11
               	cmpl	%r11d, %r10d
               	setb	%r10b
               	movzbq	%r10b, %r10
               	negq	%r10
               	movzwq	0x4e(%rsp), %r11
               	movq	%r10, 0x130(%rsp)
               	movzwq	0x5e(%rsp), %r10
               	movq	%r10, 0x138(%rsp)
               	cmpl	0x138(%rsp), %r11d
               	setb	%r11b
               	movzbq	%r11b, %r11
               	negq	%r11
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movw	%cx, 0x100(%rsp)
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movw	%dx, 0x102(%rsp)
               	andq	$0xffff, %rsi           # imm = 0xFFFF
               	movw	%si, 0x104(%rsp)
               	andq	$0xffff, %rdi           # imm = 0xFFFF
               	movw	%di, 0x106(%rsp)
               	andq	$0xffff, %r8            # imm = 0xFFFF
               	movw	%r8w, 0x108(%rsp)
               	andq	$0xffff, %r9            # imm = 0xFFFF
               	movw	%r9w, 0x10a(%rsp)
               	movq	0x130(%rsp), %r10
               	andq	$0xffff, %r10           # imm = 0xFFFF
               	movw	%r10w, 0x10c(%rsp)
               	andq	$0xffff, %r11           # imm = 0xFFFF
               	movw	%r11w, 0x10e(%rsp)
               	movzwq	0x50(%rsp,%rax,2), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movzwq	0x40(%rsp,%rax,2), %r8
               	cmpl	%edx, %r8d
               	cmovgeq	%rdi, %rsi
               	movw	%si, 0x160(%rsp,%rax,2)
               	incq	%rax
               	nop
               	cmpl	$0x8, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x100(%rsp,%rax), %rsi
               	movzbq	0x160(%rsp,%rax), %rdi
               	nopl	(%rax)
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movzwq	0x40(%rsp), %rax
               	movzwq	0x50(%rsp), %rcx
               	cmpl	%ecx, %eax
               	setae	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	negq	%rcx
               	movzwq	0x42(%rsp), %rdx
               	movzwq	0x52(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movzwq	0x44(%rsp), %rsi
               	movzwq	0x54(%rsp), %rdi
               	cmpl	%edi, %esi
               	setae	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movzwq	0x46(%rsp), %rdi
               	movzwq	0x56(%rsp), %r8
               	cmpl	%r8d, %edi
               	setae	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movzwq	0x48(%rsp), %r8
               	movzwq	0x58(%rsp), %r9
               	cmpl	%r9d, %r8d
               	setae	%r8b
               	movzbq	%r8b, %r8
               	negq	%r8
               	movzwq	0x4a(%rsp), %r9
               	movzwq	0x5a(%rsp), %r10
               	cmpl	%r10d, %r9d
               	setae	%r9b
               	movzbq	%r9b, %r9
               	negq	%r9
               	movzwq	0x4c(%rsp), %r10
               	movzwq	0x5c(%rsp), %r11
               	cmpl	%r11d, %r10d
               	setae	%r10b
               	movzbq	%r10b, %r10
               	negq	%r10
               	movzwq	0x4e(%rsp), %r11
               	movq	%r10, 0x130(%rsp)
               	movzwq	0x5e(%rsp), %r10
               	movq	%r10, 0x138(%rsp)
               	cmpl	0x138(%rsp), %r11d
               	setae	%r11b
               	movzbq	%r11b, %r11
               	negq	%r11
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movw	%cx, 0x100(%rsp)
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movw	%dx, 0x102(%rsp)
               	andq	$0xffff, %rsi           # imm = 0xFFFF
               	movw	%si, 0x104(%rsp)
               	andq	$0xffff, %rdi           # imm = 0xFFFF
               	movw	%di, 0x106(%rsp)
               	andq	$0xffff, %r8            # imm = 0xFFFF
               	movw	%r8w, 0x108(%rsp)
               	andq	$0xffff, %r9            # imm = 0xFFFF
               	movw	%r9w, 0x10a(%rsp)
               	movq	0x130(%rsp), %r10
               	andq	$0xffff, %r10           # imm = 0xFFFF
               	movw	%r10w, 0x10c(%rsp)
               	andq	$0xffff, %r11           # imm = 0xFFFF
               	movw	%r11w, 0x10e(%rsp)
               	movzwq	0x50(%rsp,%rax,2), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movzwq	0x40(%rsp,%rax,2), %r8
               	cmpl	%edx, %r8d
               	cmovlq	%rdi, %rsi
               	movw	%si, 0x160(%rsp,%rax,2)
               	incq	%rax
               	nop
               	cmpl	$0x8, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x100(%rsp,%rax), %rsi
               	movzbq	0x160(%rsp,%rax), %rdi
               	nopl	(%rax)
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movswq	0x60(%rsp), %rax
               	movswq	0x70(%rsp), %rcx
               	cmpl	%ecx, %eax
               	setne	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	negq	%rcx
               	movswq	0x62(%rsp), %rdx
               	movswq	0x72(%rsp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movswq	0x64(%rsp), %rsi
               	movswq	0x74(%rsp), %rdi
               	cmpl	%edi, %esi
               	setne	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movswq	0x66(%rsp), %rdi
               	movswq	0x76(%rsp), %r8
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movswq	0x68(%rsp), %r8
               	movswq	0x78(%rsp), %r9
               	cmpl	%r9d, %r8d
               	setne	%r8b
               	movzbq	%r8b, %r8
               	negq	%r8
               	movswq	0x6a(%rsp), %r9
               	movswq	0x7a(%rsp), %r10
               	cmpl	%r10d, %r9d
               	setne	%r9b
               	movzbq	%r9b, %r9
               	negq	%r9
               	movswq	0x6c(%rsp), %r10
               	movswq	0x7c(%rsp), %r11
               	cmpl	%r11d, %r10d
               	setne	%r10b
               	movzbq	%r10b, %r10
               	negq	%r10
               	movswq	0x6e(%rsp), %r11
               	movq	%r10, 0x130(%rsp)
               	movswq	0x7e(%rsp), %r10
               	movq	%r10, 0x138(%rsp)
               	cmpl	0x138(%rsp), %r11d
               	setne	%r11b
               	movzbq	%r11b, %r11
               	negq	%r11
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movw	%cx, 0x100(%rsp)
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movw	%dx, 0x102(%rsp)
               	andq	$0xffff, %rsi           # imm = 0xFFFF
               	movw	%si, 0x104(%rsp)
               	andq	$0xffff, %rdi           # imm = 0xFFFF
               	movw	%di, 0x106(%rsp)
               	andq	$0xffff, %r8            # imm = 0xFFFF
               	movw	%r8w, 0x108(%rsp)
               	andq	$0xffff, %r9            # imm = 0xFFFF
               	movw	%r9w, 0x10a(%rsp)
               	movq	0x130(%rsp), %r10
               	andq	$0xffff, %r10           # imm = 0xFFFF
               	movw	%r10w, 0x10c(%rsp)
               	andq	$0xffff, %r11           # imm = 0xFFFF
               	movw	%r11w, 0x10e(%rsp)
               	movswq	0x70(%rsp,%rax,2), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movswq	0x60(%rsp,%rax,2), %r8
               	cmpl	%edx, %r8d
               	cmoveq	%rdi, %rsi
               	movw	%si, 0x160(%rsp,%rax,2)
               	incq	%rax
               	nop
               	cmpl	$0x8, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x100(%rsp,%rax), %rsi
               	movzbq	0x160(%rsp,%rax), %rdi
               	nopl	(%rax)
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movswq	0x60(%rsp), %rax
               	movswq	0x70(%rsp), %rcx
               	cmpl	%ecx, %eax
               	setle	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	negq	%rcx
               	movswq	0x62(%rsp), %rdx
               	movswq	0x72(%rsp), %rsi
               	cmpl	%esi, %edx
               	setle	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movswq	0x64(%rsp), %rsi
               	movswq	0x74(%rsp), %rdi
               	cmpl	%edi, %esi
               	setle	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movswq	0x66(%rsp), %rdi
               	movswq	0x76(%rsp), %r8
               	cmpl	%r8d, %edi
               	setle	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movswq	0x68(%rsp), %r8
               	movswq	0x78(%rsp), %r9
               	cmpl	%r9d, %r8d
               	setle	%r8b
               	movzbq	%r8b, %r8
               	negq	%r8
               	movswq	0x6a(%rsp), %r9
               	movswq	0x7a(%rsp), %r10
               	cmpl	%r10d, %r9d
               	setle	%r9b
               	movzbq	%r9b, %r9
               	negq	%r9
               	movswq	0x6c(%rsp), %r10
               	movswq	0x7c(%rsp), %r11
               	cmpl	%r11d, %r10d
               	setle	%r10b
               	movzbq	%r10b, %r10
               	negq	%r10
               	movswq	0x6e(%rsp), %r11
               	movq	%r10, 0x130(%rsp)
               	movswq	0x7e(%rsp), %r10
               	movq	%r10, 0x138(%rsp)
               	cmpl	0x138(%rsp), %r11d
               	setle	%r11b
               	movzbq	%r11b, %r11
               	negq	%r11
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movw	%cx, 0x100(%rsp)
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movw	%dx, 0x102(%rsp)
               	andq	$0xffff, %rsi           # imm = 0xFFFF
               	movw	%si, 0x104(%rsp)
               	andq	$0xffff, %rdi           # imm = 0xFFFF
               	movw	%di, 0x106(%rsp)
               	andq	$0xffff, %r8            # imm = 0xFFFF
               	movw	%r8w, 0x108(%rsp)
               	andq	$0xffff, %r9            # imm = 0xFFFF
               	movw	%r9w, 0x10a(%rsp)
               	movq	0x130(%rsp), %r10
               	andq	$0xffff, %r10           # imm = 0xFFFF
               	movw	%r10w, 0x10c(%rsp)
               	andq	$0xffff, %r11           # imm = 0xFFFF
               	movw	%r11w, 0x10e(%rsp)
               	movswq	0x70(%rsp,%rax,2), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movswq	0x60(%rsp,%rax,2), %r8
               	cmpl	%edx, %r8d
               	cmovgq	%rdi, %rsi
               	movw	%si, 0x160(%rsp,%rax,2)
               	incq	%rax
               	nop
               	cmpl	$0x8, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x100(%rsp,%rax), %rsi
               	movzbq	0x160(%rsp,%rax), %rdi
               	nopl	(%rax)
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	0x60(%rsp), %xmm0
               	movups	0x70(%rsp), %xmm1
               	vpcmpgtw	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x100(%rsp)
               	xorl	%eax, %eax
               	movswq	0x70(%rsp,%rax,2), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movswq	0x60(%rsp,%rax,2), %r8
               	cmpl	%edx, %r8d
               	cmovleq	%rdi, %rsi
               	movw	%si, 0x160(%rsp,%rax,2)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x100(%rsp,%rax), %rsi
               	movzbq	0x160(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	0x80(%rsp), %eax
               	movl	0x90(%rsp), %edx
               	cmpl	%edx, %eax
               	setb	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	negq	%rdx
               	movl	0x84(%rsp), %esi
               	movl	0x94(%rsp), %edi
               	cmpl	%edi, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movl	0x88(%rsp), %edi
               	movl	0x98(%rsp), %r8d
               	cmpl	%r8d, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movl	0x8c(%rsp), %r8d
               	movl	0x9c(%rsp), %r11d
               	cmpl	%r11d, %r8d
               	setb	%r8b
               	movzbq	%r8b, %r8
               	negq	%r8
               	movl	%edx, 0x100(%rsp)
               	movl	%esi, 0x104(%rsp)
               	movl	%edi, 0x108(%rsp)
               	movl	%r8d, 0x10c(%rsp)
               	movl	0x90(%rsp,%rax,4), %edx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movl	0x80(%rsp,%rax,4), %r8d
               	cmpl	%edx, %r8d
               	cmovaeq	%rdi, %rsi
               	movl	%esi, 0x160(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x100(%rsp,%rax), %rsi
               	movzbq	0x160(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	0x80(%rsp), %xmm0
               	movups	0x90(%rsp), %xmm1
               	vpcmpeqd	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x100(%rsp)
               	xorl	%eax, %eax
               	movl	0x90(%rsp,%rax,4), %edx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movl	0x80(%rsp,%rax,4), %r8d
               	cmpl	%edx, %r8d
               	cmovneq	%rdi, %rsi
               	movl	%esi, 0x160(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x100(%rsp,%rax), %rsi
               	movzbq	0x160(%rsp,%rax), %rdi
               	nopw	(%rax,%rax)
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	0xb0(%rsp), %xmm0
               	movups	0xa0(%rsp), %xmm1
               	vpcmpgtd	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x100(%rsp)
               	xorl	%eax, %eax
               	movl	0xb0(%rsp,%rax,4), %edx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movl	0xa0(%rsp,%rax,4), %r8d
               	cmpl	%edx, %r8d
               	cmovgeq	%rdi, %rsi
               	movl	%esi, 0x160(%rsp,%rax,4)
               	incq	%rax
               	nopw	(%rax,%rax)
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x100(%rsp,%rax), %rsi
               	movzbq	0x160(%rsp,%rax), %rdi
               	nopl	(%rax)
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	0xa0(%rsp), %eax
               	movl	0xb0(%rsp), %edx
               	cmpl	%edx, %eax
               	setge	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	negq	%rdx
               	movl	0xa4(%rsp), %esi
               	movl	0xb4(%rsp), %edi
               	cmpl	%edi, %esi
               	setge	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movl	0xa8(%rsp), %edi
               	movl	0xb8(%rsp), %r8d
               	cmpl	%r8d, %edi
               	setge	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movl	0xac(%rsp), %r8d
               	movl	0xbc(%rsp), %r11d
               	cmpl	%r11d, %r8d
               	setge	%r8b
               	movzbq	%r8b, %r8
               	negq	%r8
               	movl	%edx, 0x100(%rsp)
               	movl	%esi, 0x104(%rsp)
               	movl	%edi, 0x108(%rsp)
               	movl	%r8d, 0x10c(%rsp)
               	movl	0xb0(%rsp,%rax,4), %edx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movl	0xa0(%rsp,%rax,4), %r8d
               	cmpl	%edx, %r8d
               	cmovlq	%rdi, %rsi
               	movl	%esi, 0x160(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x100(%rsp,%rax), %rsi
               	movzbq	0x160(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	0xa0(%rsp), %eax
               	movl	0xb0(%rsp), %edx
               	cmpl	%edx, %eax
               	setne	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	negq	%rdx
               	movl	0xa4(%rsp), %esi
               	movl	0xb4(%rsp), %edi
               	cmpl	%edi, %esi
               	setne	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movl	0xa8(%rsp), %edi
               	movl	0xb8(%rsp), %r8d
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movl	0xac(%rsp), %r8d
               	movl	0xbc(%rsp), %r11d
               	cmpl	%r11d, %r8d
               	setne	%r8b
               	movzbq	%r8b, %r8
               	negq	%r8
               	movl	%edx, 0x100(%rsp)
               	movl	%esi, 0x104(%rsp)
               	movl	%edi, 0x108(%rsp)
               	movl	%r8d, 0x10c(%rsp)
               	movl	0xb0(%rsp,%rax,4), %edx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movl	0xa0(%rsp,%rax,4), %r8d
               	cmpl	%edx, %r8d
               	cmoveq	%rdi, %rsi
               	movl	%esi, 0x160(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x100(%rsp,%rax), %rsi
               	movzbq	0x160(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	0xc0(%rsp), %rax
               	movq	0xd0(%rsp), %rdx
               	cmpq	%rdx, %rax
               	setb	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	negq	%rdx
               	movq	0xc8(%rsp), %rsi
               	movq	0xd8(%rsp), %rdi
               	cmpq	%rdi, %rsi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movq	%rdx, 0x100(%rsp)
               	movq	%rsi, 0x108(%rsp)
               	movq	0xd0(%rsp,%rax,8), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movq	0xc0(%rsp,%rax,8), %r8
               	cmpq	%rdx, %r8
               	cmovaeq	%rdi, %rsi
               	movq	%rsi, 0x160(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x100(%rsp,%rax), %rsi
               	movzbq	0x160(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	0xc0(%rsp), %rax
               	movq	0xd0(%rsp), %rdx
               	cmpq	%rdx, %rax
               	seta	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	negq	%rdx
               	movq	0xc8(%rsp), %rsi
               	movq	0xd8(%rsp), %rdi
               	cmpq	%rdi, %rsi
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movq	%rdx, 0x100(%rsp)
               	movq	%rsi, 0x108(%rsp)
               	movq	0xd0(%rsp,%rax,8), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movq	0xc0(%rsp,%rax,8), %r8
               	cmpq	%rdx, %r8
               	cmovbeq	%rdi, %rsi
               	movq	%rsi, 0x160(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x100(%rsp,%rax), %rsi
               	movzbq	0x160(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	0xf0(%rsp), %xmm0
               	movups	0xe0(%rsp), %xmm1
               	vpcmpgtq	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x100(%rsp)
               	xorl	%eax, %eax
               	movq	0xf0(%rsp,%rax,8), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movq	0xe0(%rsp,%rax,8), %r8
               	cmpq	%rdx, %r8
               	cmovgeq	%rdi, %rsi
               	movq	%rsi, 0x160(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x100(%rsp,%rax), %rsi
               	movzbq	0x160(%rsp,%rax), %rdi
               	nopl	(%rax,%rax)
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	0xe0(%rsp), %xmm0
               	movups	0xf0(%rsp), %xmm1
               	vpcmpeqq	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x100(%rsp)
               	xorl	%eax, %eax
               	movq	0xf0(%rsp,%rax,8), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movq	0xe0(%rsp,%rax,8), %r8
               	cmpq	%rdx, %r8
               	cmovneq	%rdi, %rsi
               	movq	%rsi, 0x160(%rsp,%rax,8)
               	incq	%rax
               	nopw	(%rax,%rax)
               	cmpl	$0x2, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x100(%rsp,%rax), %rsi
               	movzbq	0x160(%rsp,%rax), %rdi
               	nopl	(%rax)
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movzbq	0x148(%rsp), %rax
               	movzbq	0x150(%rsp), %rcx
               	cmpl	%ecx, %eax
               	setb	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	negq	%rcx
               	movzbq	0x149(%rsp), %rdx
               	movzbq	0x151(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movzbq	0x14a(%rsp), %rsi
               	movzbq	0x152(%rsp), %rdi
               	cmpl	%edi, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movzbq	0x14b(%rsp), %rdi
               	movzbq	0x153(%rsp), %r8
               	cmpl	%r8d, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movzbq	0x14c(%rsp), %r8
               	movzbq	0x154(%rsp), %r9
               	cmpl	%r9d, %r8d
               	setb	%r8b
               	movzbq	%r8b, %r8
               	negq	%r8
               	movzbq	0x14d(%rsp), %r9
               	movzbq	0x155(%rsp), %r10
               	cmpl	%r10d, %r9d
               	setb	%r9b
               	movzbq	%r9b, %r9
               	negq	%r9
               	movzbq	0x14e(%rsp), %r10
               	movzbq	0x156(%rsp), %r11
               	cmpl	%r11d, %r10d
               	setb	%r10b
               	movzbq	%r10b, %r10
               	negq	%r10
               	movzbq	0x14f(%rsp), %r11
               	movq	%r10, 0x130(%rsp)
               	movzbq	0x157(%rsp), %r10
               	movq	%r10, 0x138(%rsp)
               	cmpl	0x138(%rsp), %r11d
               	setb	%r11b
               	movzbq	%r11b, %r11
               	negq	%r11
               	andq	$0xff, %rcx
               	movb	%cl, 0x158(%rsp)
               	andq	$0xff, %rdx
               	movb	%dl, 0x159(%rsp)
               	andq	$0xff, %rsi
               	movb	%sil, 0x15a(%rsp)
               	andq	$0xff, %rdi
               	movb	%dil, 0x15b(%rsp)
               	andq	$0xff, %r8
               	movb	%r8b, 0x15c(%rsp)
               	andq	$0xff, %r9
               	movb	%r9b, 0x15d(%rsp)
               	movq	0x130(%rsp), %r10
               	andq	$0xff, %r10
               	movb	%r10b, 0x15e(%rsp)
               	andq	$0xff, %r11
               	movb	%r11b, 0x15f(%rsp)
               	movzbq	0x150(%rsp,%rax), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movzbq	0x148(%rsp,%rax), %r8
               	cmpl	%edx, %r8d
               	cmovgeq	%rdi, %rsi
               	movb	%sil, 0x168(%rsp,%rax)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x158(%rsp,%rax), %rsi
               	movzbq	0x168(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	0x168(%rsp), %rax
               	leaq	<rip>, %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	leaq	0xf0(%rsp), %rcx
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x110(%rsp), %rdx
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movss	0x168(%rsp), %xmm0
               	movss	%xmm0, 0xf8(%rsp)
               	movss	0xf0(%rsp), %xmm0
               	movss	0x110(%rsp), %xmm1
               	ucomiss	%xmm1, %xmm0
               	sete	%sil
               	movzbq	%sil, %rsi
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rsi
               	xorl	%eax, %eax
               	negq	%rsi
               	movss	0xf4(%rsp), %xmm0
               	movss	0x114(%rsp), %xmm1
               	ucomiss	%xmm1, %xmm0
               	sete	%dil
               	movzbq	%dil, %rdi
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rdi
               	negq	%rdi
               	movss	0xf8(%rsp), %xmm0
               	movss	0x118(%rsp), %xmm1
               	ucomiss	%xmm1, %xmm0
               	sete	%r8b
               	movzbq	%r8b, %r8
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %r8
               	negq	%r8
               	movss	0xfc(%rsp), %xmm0
               	movss	0x11c(%rsp), %xmm1
               	ucomiss	%xmm1, %xmm0
               	sete	%r9b
               	movzbq	%r9b, %r9
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %r9
               	negq	%r9
               	movl	%esi, 0x100(%rsp)
               	movl	%edi, 0x104(%rsp)
               	movl	%r8d, 0x108(%rsp)
               	movl	%r9d, 0x10c(%rsp)
               	movss	0x110(%rsp,%rax,4), %xmm0
               	movq	$-0x1, %rdi
               	xorl	%r8d, %r8d
               	movss	0xf0(%rsp,%rax,4), %xmm1
               	ucomiss	%xmm0, %xmm1
               	cmovneq	%r8, %rdi
               	cmovpq	%r8, %rdi
               	movl	%edi, 0x160(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x100(%rsp,%rax), %rsi
               	movzbq	0x160(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0xf0(%rsp), %r8
               	leaq	0x110(%rsp), %r9
               	movss	0xf0(%rsp), %xmm0
               	movss	0x110(%rsp), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setne	%dl
               	movzbq	%dl, %rdx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rdx
               	xorl	%eax, %eax
               	negq	%rdx
               	movss	0xf4(%rsp), %xmm0
               	movss	0x114(%rsp), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setne	%sil
               	movzbq	%sil, %rsi
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rsi
               	negq	%rsi
               	movss	0xf8(%rsp), %xmm0
               	movss	0x118(%rsp), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setne	%dil
               	movzbq	%dil, %rdi
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rdi
               	negq	%rdi
               	movss	0xfc(%rsp), %xmm0
               	movss	0x11c(%rsp), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setne	%r10b
               	movzbq	%r10b, %r10
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %r10
               	negq	%r10
               	movl	%edx, 0x100(%rsp)
               	movl	%esi, 0x104(%rsp)
               	movl	%edi, 0x108(%rsp)
               	movl	%r10d, 0x10c(%rsp)
               	movss	0x110(%rsp,%rax,4), %xmm0
               	movq	$-0x1, %rdx
               	xorl	%esi, %esi
               	movss	0xf0(%rsp,%rax,4), %xmm1
               	ucomiss	%xmm0, %xmm1
               	movq	%rsi, %r10
               	cmovpq	%rdx, %r10
               	cmoveq	%r10, %rdx
               	movl	%edx, 0x160(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x100(%rsp,%rax), %rsi
               	movzbq	0x160(%rsp,%rax), %rdi
               	nopl	(%rax)
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0xf0(%rsp), %r8
               	leaq	0x110(%rsp), %r9
               	movss	0xf0(%rsp), %xmm0
               	movss	0x110(%rsp), %xmm1
               	comiss	%xmm0, %xmm1
               	seta	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	negq	%rdx
               	movss	0xf4(%rsp), %xmm0
               	movss	0x114(%rsp), %xmm1
               	comiss	%xmm0, %xmm1
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movss	0xf8(%rsp), %xmm0
               	movss	0x118(%rsp), %xmm1
               	comiss	%xmm0, %xmm1
               	seta	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movss	0xfc(%rsp), %xmm0
               	movss	0x11c(%rsp), %xmm1
               	comiss	%xmm0, %xmm1
               	seta	%r10b
               	movzbq	%r10b, %r10
               	negq	%r10
               	movl	%edx, 0x100(%rsp)
               	movl	%esi, 0x104(%rsp)
               	movl	%edi, 0x108(%rsp)
               	movl	%r10d, 0x10c(%rsp)
               	movss	0x110(%rsp,%rax,4), %xmm0
               	movq	$-0x1, %rdx
               	xorl	%esi, %esi
               	movss	0xf0(%rsp,%rax,4), %xmm1
               	comiss	%xmm1, %xmm0
               	cmovbeq	%rsi, %rdx
               	movl	%edx, 0x160(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x100(%rsp,%rax), %rsi
               	movzbq	0x160(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0xf0(%rsp), %r8
               	leaq	0x110(%rsp), %r9
               	movss	0xf0(%rsp), %xmm0
               	movss	0x110(%rsp), %xmm1
               	comiss	%xmm0, %xmm1
               	setae	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	negq	%rdx
               	movss	0xf4(%rsp), %xmm0
               	movss	0x114(%rsp), %xmm1
               	comiss	%xmm0, %xmm1
               	setae	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movss	0xf8(%rsp), %xmm0
               	movss	0x118(%rsp), %xmm1
               	comiss	%xmm0, %xmm1
               	setae	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movss	0xfc(%rsp), %xmm0
               	movss	0x11c(%rsp), %xmm1
               	comiss	%xmm0, %xmm1
               	setae	%r10b
               	movzbq	%r10b, %r10
               	negq	%r10
               	movl	%edx, 0x100(%rsp)
               	movl	%esi, 0x104(%rsp)
               	movl	%edi, 0x108(%rsp)
               	movl	%r10d, 0x10c(%rsp)
               	movss	0x110(%rsp,%rax,4), %xmm0
               	movq	$-0x1, %rdx
               	xorl	%esi, %esi
               	movss	0xf0(%rsp,%rax,4), %xmm1
               	comiss	%xmm1, %xmm0
               	cmovbq	%rsi, %rdx
               	movl	%edx, 0x160(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x100(%rsp,%rax), %rsi
               	movzbq	0x160(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0xf0(%rsp), %r8
               	leaq	0x110(%rsp), %r9
               	movss	0xf0(%rsp), %xmm0
               	movss	0x110(%rsp), %xmm1
               	comiss	%xmm1, %xmm0
               	seta	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	negq	%rdx
               	movss	0xf4(%rsp), %xmm0
               	movss	0x114(%rsp), %xmm1
               	comiss	%xmm1, %xmm0
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movss	0xf8(%rsp), %xmm0
               	movss	0x118(%rsp), %xmm1
               	comiss	%xmm1, %xmm0
               	seta	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movss	0xfc(%rsp), %xmm0
               	movss	0x11c(%rsp), %xmm1
               	comiss	%xmm1, %xmm0
               	seta	%r10b
               	movzbq	%r10b, %r10
               	negq	%r10
               	movl	%edx, 0x100(%rsp)
               	movl	%esi, 0x104(%rsp)
               	movl	%edi, 0x108(%rsp)
               	movl	%r10d, 0x10c(%rsp)
               	movss	0x110(%rsp,%rax,4), %xmm0
               	movq	$-0x1, %rdx
               	xorl	%esi, %esi
               	movss	0xf0(%rsp,%rax,4), %xmm1
               	comiss	%xmm0, %xmm1
               	cmovbeq	%rsi, %rdx
               	movl	%edx, 0x160(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x100(%rsp,%rax), %rsi
               	movzbq	0x160(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	nopw	(%rax,%rax)
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0xf0(%rsp), %r8
               	leaq	0x110(%rsp), %r9
               	movss	0xf0(%rsp), %xmm0
               	movss	0x110(%rsp), %xmm1
               	comiss	%xmm1, %xmm0
               	setae	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	negq	%rdx
               	movss	0xf4(%rsp), %xmm0
               	movss	0x114(%rsp), %xmm1
               	comiss	%xmm1, %xmm0
               	setae	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movss	0xf8(%rsp), %xmm0
               	movss	0x118(%rsp), %xmm1
               	comiss	%xmm1, %xmm0
               	setae	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movss	0xfc(%rsp), %xmm0
               	movss	0x11c(%rsp), %xmm1
               	comiss	%xmm1, %xmm0
               	setae	%r10b
               	movzbq	%r10b, %r10
               	negq	%r10
               	movl	%edx, 0x100(%rsp)
               	movl	%esi, 0x104(%rsp)
               	movl	%edi, 0x108(%rsp)
               	movl	%r10d, 0x10c(%rsp)
               	movss	0x110(%rsp,%rax,4), %xmm0
               	movq	$-0x1, %rdx
               	xorl	%esi, %esi
               	movss	0xf0(%rsp,%rax,4), %xmm1
               	comiss	%xmm0, %xmm1
               	cmovbq	%rsi, %rdx
               	movl	%edx, 0x160(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x100(%rsp,%rax), %rsi
               	movzbq	0x160(%rsp,%rax), %rdi
               	nopl	(%rax)
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0xf0(%rsp), %r8
               	movss	0xf0(%rsp), %xmm0
               	comiss	<rip>, %xmm0
               	seta	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	negq	%rdx
               	movss	0xf4(%rsp), %xmm0
               	comiss	<rip>, %xmm0
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movss	0xf8(%rsp), %xmm0
               	comiss	<rip>, %xmm0
               	seta	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movss	0xfc(%rsp), %xmm0
               	comiss	<rip>, %xmm0
               	seta	%r9b
               	movzbq	%r9b, %r9
               	negq	%r9
               	movl	%edx, 0x100(%rsp)
               	movl	%esi, 0x104(%rsp)
               	movl	%edi, 0x108(%rsp)
               	movl	%r9d, 0x10c(%rsp)
               	movq	$-0x1, %rdx
               	xorl	%esi, %esi
               	movss	0xf0(%rsp,%rax,4), %xmm0
               	comiss	<rip>, %xmm0
               	cmovbeq	%rsi, %rdx
               	movl	%edx, 0x160(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x100(%rsp,%rax), %rsi
               	movzbq	0x160(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x168(%rsp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	0xf0(%rsp), %rcx
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x110(%rsp), %rdx
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movsd	0x168(%rsp), %xmm0
               	movsd	%xmm0, 0xf8(%rsp)
               	movsd	0xf0(%rsp), %xmm1
               	movsd	0x110(%rsp), %xmm2
               	ucomisd	%xmm2, %xmm1
               	sete	%sil
               	movzbq	%sil, %rsi
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rsi
               	xorl	%eax, %eax
               	negq	%rsi
               	movsd	0x118(%rsp), %xmm1
               	ucomisd	%xmm1, %xmm0
               	sete	%dil
               	movzbq	%dil, %rdi
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rdi
               	negq	%rdi
               	movq	%rsi, 0x100(%rsp)
               	movq	%rdi, 0x108(%rsp)
               	vmovq	0x110(%rsp,%rax,8), %xmm0
               	movq	$-0x1, %rdi
               	xorl	%r8d, %r8d
               	vmovq	0xf0(%rsp,%rax,8), %xmm1
               	ucomisd	%xmm0, %xmm1
               	cmovneq	%r8, %rdi
               	cmovpq	%r8, %rdi
               	movq	%rdi, 0x160(%rsp,%rax,8)
               	incq	%rax
               	nopl	(%rax)
               	cmpl	$0x2, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x100(%rsp,%rax), %rsi
               	movzbq	0x160(%rsp,%rax), %rdi
               	nopl	(%rax)
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movsd	0xf0(%rsp), %xmm0
               	movsd	0x110(%rsp), %xmm1
               	ucomisd	%xmm1, %xmm0
               	setne	%dl
               	movzbq	%dl, %rdx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rdx
               	xorl	%eax, %eax
               	negq	%rdx
               	movsd	0xf8(%rsp), %xmm0
               	movsd	0x118(%rsp), %xmm1
               	ucomisd	%xmm1, %xmm0
               	setne	%sil
               	movzbq	%sil, %rsi
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rsi
               	negq	%rsi
               	movq	%rdx, 0x100(%rsp)
               	movq	%rsi, 0x108(%rsp)
               	vmovq	0x110(%rsp,%rax,8), %xmm0
               	movq	$-0x1, %rdx
               	xorl	%esi, %esi
               	vmovq	0xf0(%rsp,%rax,8), %xmm1
               	ucomisd	%xmm0, %xmm1
               	movq	%rsi, %r10
               	cmovpq	%rdx, %r10
               	cmoveq	%r10, %rdx
               	movq	%rdx, 0x160(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x100(%rsp,%rax), %rsi
               	movzbq	0x160(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movsd	0xf0(%rsp), %xmm0
               	movsd	0x110(%rsp), %xmm1
               	comisd	%xmm0, %xmm1
               	seta	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	negq	%rdx
               	movsd	0xf8(%rsp), %xmm0
               	movsd	0x118(%rsp), %xmm1
               	comisd	%xmm0, %xmm1
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movq	%rdx, 0x100(%rsp)
               	movq	%rsi, 0x108(%rsp)
               	vmovq	0x110(%rsp,%rax,8), %xmm0
               	movq	$-0x1, %rdx
               	xorl	%esi, %esi
               	vmovq	0xf0(%rsp,%rax,8), %xmm1
               	comisd	%xmm1, %xmm0
               	cmovbeq	%rsi, %rdx
               	movq	%rdx, 0x160(%rsp,%rax,8)
               	incq	%rax
               	nopw	(%rax,%rax)
               	cmpl	$0x2, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x100(%rsp,%rax), %rsi
               	movzbq	0x160(%rsp,%rax), %rdi
               	nopl	(%rax)
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x100(%rsp), %rdx
               	movzbq	(%rsp), %rax
               	cmpl	$0x64, %eax
               	seta	%sil
               	movzbq	%sil, %rsi
               	xorl	%eax, %eax
               	negq	%rsi
               	movb	%sil, 0x100(%rsp)
               	movzbq	0x1(%rsp), %rsi
               	cmpl	$0x64, %esi
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x101(%rsp)
               	movzbq	0x2(%rsp), %rsi
               	cmpl	$0x64, %esi
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x102(%rsp)
               	movzbq	0x3(%rsp), %rsi
               	cmpl	$0x64, %esi
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x103(%rsp)
               	movzbq	0x4(%rsp), %rsi
               	cmpl	$0x64, %esi
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x104(%rsp)
               	movzbq	0x5(%rsp), %rsi
               	cmpl	$0x64, %esi
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x105(%rsp)
               	movzbq	0x6(%rsp), %rsi
               	cmpl	$0x64, %esi
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x106(%rsp)
               	movzbq	0x7(%rsp), %rsi
               	cmpl	$0x64, %esi
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x107(%rsp)
               	movzbq	0x8(%rsp), %rsi
               	cmpl	$0x64, %esi
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x108(%rsp)
               	movzbq	0x9(%rsp), %rsi
               	cmpl	$0x64, %esi
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x109(%rsp)
               	movzbq	0xa(%rsp), %rsi
               	cmpl	$0x64, %esi
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x10a(%rsp)
               	movzbq	0xb(%rsp), %rsi
               	cmpl	$0x64, %esi
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x10b(%rsp)
               	movzbq	0xc(%rsp), %rsi
               	cmpl	$0x64, %esi
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x10c(%rsp)
               	movzbq	0xd(%rsp), %rsi
               	cmpl	$0x64, %esi
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x10d(%rsp)
               	movzbq	0xe(%rsp), %rsi
               	cmpl	$0x64, %esi
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x10e(%rsp)
               	movzbq	0xf(%rsp), %rsi
               	cmpl	$0x64, %esi
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x10f(%rsp)
               	leaq	0x110(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movq	$-0x1, %rdx
               	xorl	%esi, %esi
               	movzbq	(%rsp,%rax), %rdi
               	cmpl	$0x64, %edi
               	cmovleq	%rsi, %rdx
               	movb	%dl, 0x160(%rsp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x110(%rsp,%rax), %rsi
               	movzbq	0x160(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x100(%rsp), %rdx
               	movzbq	(%rsp), %rax
               	cmpl	$0x3, %eax
               	sete	%sil
               	movzbq	%sil, %rsi
               	xorl	%eax, %eax
               	negq	%rsi
               	movb	%sil, 0x100(%rsp)
               	movzbq	0x1(%rsp), %rsi
               	cmpl	$0x3, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x101(%rsp)
               	movzbq	0x2(%rsp), %rsi
               	cmpl	$0x3, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x102(%rsp)
               	movzbq	0x3(%rsp), %rsi
               	cmpl	$0x3, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x103(%rsp)
               	movzbq	0x4(%rsp), %rsi
               	cmpl	$0x3, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x104(%rsp)
               	movzbq	0x5(%rsp), %rsi
               	cmpl	$0x3, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x105(%rsp)
               	movzbq	0x6(%rsp), %rsi
               	cmpl	$0x3, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x106(%rsp)
               	movzbq	0x7(%rsp), %rsi
               	cmpl	$0x3, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x107(%rsp)
               	movzbq	0x8(%rsp), %rsi
               	cmpl	$0x3, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x108(%rsp)
               	movzbq	0x9(%rsp), %rsi
               	cmpl	$0x3, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x109(%rsp)
               	movzbq	0xa(%rsp), %rsi
               	cmpl	$0x3, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x10a(%rsp)
               	movzbq	0xb(%rsp), %rsi
               	cmpl	$0x3, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x10b(%rsp)
               	movzbq	0xc(%rsp), %rsi
               	cmpl	$0x3, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x10c(%rsp)
               	movzbq	0xd(%rsp), %rsi
               	cmpl	$0x3, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x10d(%rsp)
               	movzbq	0xe(%rsp), %rsi
               	cmpl	$0x3, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x10e(%rsp)
               	movzbq	0xf(%rsp), %rsi
               	cmpl	$0x3, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x10f(%rsp)
               	leaq	0x110(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movq	$-0x1, %rdx
               	xorl	%esi, %esi
               	movzbq	(%rsp,%rax), %rdi
               	cmpl	$0x3, %edi
               	cmovneq	%rsi, %rdx
               	movb	%dl, 0x160(%rsp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x110(%rsp,%rax), %rsi
               	movzbq	0x160(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x100(%rsp), %rdx
               	movzbq	(%rsp), %rax
               	cmpl	$0xff, %eax
               	setb	%sil
               	movzbq	%sil, %rsi
               	xorl	%eax, %eax
               	negq	%rsi
               	movb	%sil, 0x100(%rsp)
               	movzbq	0x1(%rsp), %rsi
               	cmpl	$0xff, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x101(%rsp)
               	movzbq	0x2(%rsp), %rsi
               	cmpl	$0xff, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x102(%rsp)
               	movzbq	0x3(%rsp), %rsi
               	cmpl	$0xff, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x103(%rsp)
               	movzbq	0x4(%rsp), %rsi
               	cmpl	$0xff, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x104(%rsp)
               	movzbq	0x5(%rsp), %rsi
               	cmpl	$0xff, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x105(%rsp)
               	movzbq	0x6(%rsp), %rsi
               	cmpl	$0xff, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x106(%rsp)
               	movzbq	0x7(%rsp), %rsi
               	cmpl	$0xff, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x107(%rsp)
               	movzbq	0x8(%rsp), %rsi
               	cmpl	$0xff, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x108(%rsp)
               	movzbq	0x9(%rsp), %rsi
               	cmpl	$0xff, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x109(%rsp)
               	movzbq	0xa(%rsp), %rsi
               	cmpl	$0xff, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x10a(%rsp)
               	movzbq	0xb(%rsp), %rsi
               	cmpl	$0xff, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x10b(%rsp)
               	movzbq	0xc(%rsp), %rsi
               	cmpl	$0xff, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x10c(%rsp)
               	movzbq	0xd(%rsp), %rsi
               	cmpl	$0xff, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x10d(%rsp)
               	movzbq	0xe(%rsp), %rsi
               	cmpl	$0xff, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x10e(%rsp)
               	movzbq	0xf(%rsp), %rsi
               	cmpl	$0xff, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x10f(%rsp)
               	leaq	0x110(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movq	$-0x1, %rdx
               	xorl	%esi, %esi
               	movzbq	(%rsp,%rax), %rdi
               	cmpl	$0xff, %edi
               	cmovgeq	%rsi, %rdx
               	movb	%dl, 0x160(%rsp,%rax)
               	incq	%rax
               	nopl	(%rax)
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x110(%rsp,%rax), %rsi
               	movzbq	0x160(%rsp,%rax), %rdi
               	nopl	(%rax)
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	$-0x5, %rax
               	leaq	0x100(%rsp), %rsi
               	movsbq	0x20(%rsp), %rcx
               	cmpl	%eax, %ecx
               	setg	%dil
               	movzbq	%dil, %rdi
               	xorl	%ecx, %ecx
               	negq	%rdi
               	movb	%dil, 0x100(%rsp)
               	movsbq	0x21(%rsp), %rdi
               	cmpl	%eax, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x101(%rsp)
               	movsbq	0x22(%rsp), %rdi
               	cmpl	%eax, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x102(%rsp)
               	movsbq	0x23(%rsp), %rdi
               	cmpl	%eax, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x103(%rsp)
               	movsbq	0x24(%rsp), %rdi
               	cmpl	%eax, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x104(%rsp)
               	movsbq	0x25(%rsp), %rdi
               	cmpl	%eax, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x105(%rsp)
               	movsbq	0x26(%rsp), %rdi
               	cmpl	%eax, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x106(%rsp)
               	movsbq	0x27(%rsp), %rdi
               	cmpl	%eax, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x107(%rsp)
               	movsbq	0x28(%rsp), %rdi
               	cmpl	%eax, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x108(%rsp)
               	movsbq	0x29(%rsp), %rdi
               	cmpl	%eax, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x109(%rsp)
               	movsbq	0x2a(%rsp), %rdi
               	cmpl	%eax, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x10a(%rsp)
               	movsbq	0x2b(%rsp), %rdi
               	cmpl	%eax, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x10b(%rsp)
               	movsbq	0x2c(%rsp), %rdi
               	cmpl	%eax, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x10c(%rsp)
               	movsbq	0x2d(%rsp), %rdi
               	cmpl	%eax, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x10d(%rsp)
               	movsbq	0x2e(%rsp), %rdi
               	cmpl	%eax, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x10e(%rsp)
               	movsbq	0x2f(%rsp), %rdi
               	cmpl	%eax, %edi
               	setg	%al
               	movzbq	%al, %rax
               	negq	%rax
               	movb	%al, 0x10f(%rsp)
               	leaq	0x110(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	movq	$-0x1, %rax
               	xorl	%esi, %esi
               	movsbq	0x20(%rsp,%rcx), %rdi
               	cmpl	$-0x5, %edi
               	cmovleq	%rsi, %rax
               	movb	%al, 0x160(%rsp,%rcx)
               	incq	%rcx
               	cmpl	$0x10, %ecx
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x110(%rsp,%rax), %rsi
               	movzbq	0x160(%rsp,%rax), %rdi
               	nopw	(%rax,%rax)
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movl	0xa0(%rsp), %edx
               	testl	%edx, %edx
               	setl	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	0xa4(%rsp), %esi
               	testl	%esi, %esi
               	setl	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movl	0xa8(%rsp), %edi
               	testl	%edi, %edi
               	setl	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movl	0xac(%rsp), %r9d
               	testl	%r9d, %r9d
               	setl	%r9b
               	movzbq	%r9b, %r9
               	negq	%r9
               	movl	%edx, 0x100(%rsp)
               	movl	%esi, 0x104(%rsp)
               	movl	%edi, 0x108(%rsp)
               	movl	%r9d, 0x10c(%rsp)
               	movq	$-0x1, %rdx
               	xorl	%esi, %esi
               	movl	0xa0(%rsp,%rax,4), %edi
               	testl	%edi, %edi
               	cmovgeq	%rsi, %rdx
               	movl	%edx, 0x160(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x100(%rsp,%rax), %rsi
               	movzbq	0x160(%rsp,%rax), %rdi
               	nopw	(%rax,%rax)
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	0xc0(%rsp), %rax
               	cmpq	$0x5, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	negq	%rdx
               	movq	0xc8(%rsp), %rsi
               	cmpq	$0x5, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movq	%rdx, 0x100(%rsp)
               	movq	%rsi, 0x108(%rsp)
               	movq	$-0x1, %rdx
               	xorl	%esi, %esi
               	movq	0xc0(%rsp,%rax,8), %rdi
               	cmpq	$0x5, %rdi
               	cmoveq	%rsi, %rdx
               	movq	%rdx, 0x160(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x100(%rsp,%rax), %rsi
               	movzbq	0x160(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	nopl	(%rax,%rax)
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x100(%rsp), %rdx
               	movzbq	(%rsp), %rax
               	cmpl	$0x64, %eax
               	setb	%sil
               	movzbq	%sil, %rsi
               	xorl	%eax, %eax
               	negq	%rsi
               	movb	%sil, 0x100(%rsp)
               	movzbq	0x1(%rsp), %rsi
               	cmpl	$0x64, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x101(%rsp)
               	movzbq	0x2(%rsp), %rsi
               	cmpl	$0x64, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x102(%rsp)
               	movzbq	0x3(%rsp), %rsi
               	cmpl	$0x64, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x103(%rsp)
               	movzbq	0x4(%rsp), %rsi
               	cmpl	$0x64, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x104(%rsp)
               	movzbq	0x5(%rsp), %rsi
               	cmpl	$0x64, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x105(%rsp)
               	movzbq	0x6(%rsp), %rsi
               	cmpl	$0x64, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x106(%rsp)
               	movzbq	0x7(%rsp), %rsi
               	cmpl	$0x64, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x107(%rsp)
               	movzbq	0x8(%rsp), %rsi
               	cmpl	$0x64, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x108(%rsp)
               	movzbq	0x9(%rsp), %rsi
               	cmpl	$0x64, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x109(%rsp)
               	movzbq	0xa(%rsp), %rsi
               	cmpl	$0x64, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x10a(%rsp)
               	movzbq	0xb(%rsp), %rsi
               	cmpl	$0x64, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x10b(%rsp)
               	movzbq	0xc(%rsp), %rsi
               	cmpl	$0x64, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x10c(%rsp)
               	movzbq	0xd(%rsp), %rsi
               	cmpl	$0x64, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x10d(%rsp)
               	movzbq	0xe(%rsp), %rsi
               	cmpl	$0x64, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x10e(%rsp)
               	movzbq	0xf(%rsp), %rsi
               	cmpl	$0x64, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x10f(%rsp)
               	leaq	0x110(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movq	$-0x1, %rdx
               	xorl	%esi, %esi
               	movzbq	(%rsp,%rax), %rdi
               	cmpl	$0x64, %edi
               	cmovgeq	%rsi, %rdx
               	movb	%dl, 0x160(%rsp,%rax)
               	incq	%rax
               	nopl	(%rax)
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x110(%rsp,%rax), %rsi
               	movzbq	0x160(%rsp,%rax), %rdi
               	nopl	(%rax)
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movl	0xa0(%rsp), %edx
               	testl	%edx, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	0xa4(%rsp), %esi
               	testl	%esi, %esi
               	setge	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movl	0xa8(%rsp), %edi
               	testl	%edi, %edi
               	setge	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movl	0xac(%rsp), %r9d
               	testl	%r9d, %r9d
               	setge	%r9b
               	movzbq	%r9b, %r9
               	negq	%r9
               	movl	%edx, 0x100(%rsp)
               	movl	%esi, 0x104(%rsp)
               	movl	%edi, 0x108(%rsp)
               	movl	%r9d, 0x10c(%rsp)
               	movq	$-0x1, %rdx
               	xorl	%esi, %esi
               	movl	0xa0(%rsp,%rax,4), %edi
               	testl	%edi, %edi
               	cmovlq	%rsi, %rdx
               	movl	%edx, 0x160(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x100(%rsp,%rax), %rsi
               	movzbq	0x160(%rsp,%rax), %rdi
               	nopw	(%rax,%rax)
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm1
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm2
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	vmovq	%r11, %xmm0
               	vpbroadcastq	%xmm0, %xmm0
               	vpand	%xmm1, %xmm0, %xmm1
               	vpcmpeqd	%xmm3, %xmm3, %xmm3
               	vpxor	%xmm3, %xmm0, %xmm0
               	vpand	%xmm2, %xmm0, %xmm0
               	vpor	%xmm0, %xmm1, %xmm0
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	cmpq	$0x1, %rax
               	jne	<addr>
               	vpextrd	$0x1, %xmm0, %eax
               	movslq	%eax, %rax
               	cmpq	$0x4, %rax
               	jne	<addr>
               	vpextrd	$0x2, %xmm0, %eax
               	movslq	%eax, %rax
               	cmpq	$0x3, %rax
               	jne	<addr>
               	vpextrd	$0x3, %xmm0, %eax
               	movslq	%eax, %rax
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0x33, %eax
               	addq	$0x178, %rsp            # imm = 0x178
               	retq
               	xorl	%eax, %eax
               	addq	$0x178, %rsp            # imm = 0x178
               	retq
               	movl	$0x31, %eax
               	addq	$0x178, %rsp            # imm = 0x178
               	retq
               	movl	$0x30, %eax
               	addq	$0x178, %rsp            # imm = 0x178
               	retq
               	movl	$0x2f, %eax
               	addq	$0x178, %rsp            # imm = 0x178
               	retq
               	movl	$0x2e, %eax
               	addq	$0x178, %rsp            # imm = 0x178
               	retq
               	movl	$0x2d, %eax
               	addq	$0x178, %rsp            # imm = 0x178
               	retq
               	movl	$0x2c, %eax
               	addq	$0x178, %rsp            # imm = 0x178
               	retq
               	movl	$0x2b, %eax
               	addq	$0x178, %rsp            # imm = 0x178
               	retq
               	movl	$0x2a, %eax
               	addq	$0x178, %rsp            # imm = 0x178
               	retq
               	movl	$0x29, %eax
               	addq	$0x178, %rsp            # imm = 0x178
               	retq
               	movl	$0x28, %eax
               	addq	$0x178, %rsp            # imm = 0x178
               	retq
               	movl	$0x27, %eax
               	addq	$0x178, %rsp            # imm = 0x178
               	retq
               	movl	$0x26, %eax
               	addq	$0x178, %rsp            # imm = 0x178
               	retq
               	movl	$0x25, %eax
               	addq	$0x178, %rsp            # imm = 0x178
               	retq
               	movl	$0x24, %eax
               	addq	$0x178, %rsp            # imm = 0x178
               	retq
               	movl	$0x23, %eax
               	addq	$0x178, %rsp            # imm = 0x178
               	retq
               	movl	$0x22, %eax
               	addq	$0x178, %rsp            # imm = 0x178
               	retq
               	movl	$0x21, %eax
               	addq	$0x178, %rsp            # imm = 0x178
               	retq
               	movl	$0x20, %eax
               	addq	$0x178, %rsp            # imm = 0x178
               	retq
               	movl	$0x1f, %eax
               	addq	$0x178, %rsp            # imm = 0x178
               	retq
               	movl	$0x1e, %eax
               	addq	$0x178, %rsp            # imm = 0x178
               	retq
               	movl	$0x1d, %eax
               	addq	$0x178, %rsp            # imm = 0x178
               	retq
               	movl	$0x1c, %eax
               	addq	$0x178, %rsp            # imm = 0x178
               	retq
               	movl	$0x1b, %eax
               	addq	$0x178, %rsp            # imm = 0x178
               	retq
               	movl	$0x1a, %eax
               	addq	$0x178, %rsp            # imm = 0x178
               	retq
               	movl	$0x19, %eax
               	addq	$0x178, %rsp            # imm = 0x178
               	retq
               	movl	$0x18, %eax
               	addq	$0x178, %rsp            # imm = 0x178
               	retq
               	movl	$0x17, %eax
               	addq	$0x178, %rsp            # imm = 0x178
               	retq
               	movl	$0x16, %eax
               	addq	$0x178, %rsp            # imm = 0x178
               	retq
               	movl	$0x15, %eax
               	addq	$0x178, %rsp            # imm = 0x178
               	retq
               	movl	$0x14, %eax
               	addq	$0x178, %rsp            # imm = 0x178
               	retq
               	movl	$0x13, %eax
               	addq	$0x178, %rsp            # imm = 0x178
               	retq
               	movl	$0x12, %eax
               	addq	$0x178, %rsp            # imm = 0x178
               	retq
               	movl	$0x11, %eax
               	addq	$0x178, %rsp            # imm = 0x178
               	retq
               	movl	$0x10, %eax
               	addq	$0x178, %rsp            # imm = 0x178
               	retq
               	movl	$0xf, %eax
               	addq	$0x178, %rsp            # imm = 0x178
               	retq
               	movl	$0xe, %eax
               	addq	$0x178, %rsp            # imm = 0x178
               	retq
               	movl	$0xd, %eax
               	addq	$0x178, %rsp            # imm = 0x178
               	retq
               	movl	$0xc, %eax
               	addq	$0x178, %rsp            # imm = 0x178
               	retq
               	movl	$0xb, %eax
               	addq	$0x178, %rsp            # imm = 0x178
               	retq
               	movl	$0xa, %eax
               	addq	$0x178, %rsp            # imm = 0x178
               	retq
               	movl	$0x9, %eax
               	addq	$0x178, %rsp            # imm = 0x178
               	retq
               	movl	$0x8, %eax
               	addq	$0x178, %rsp            # imm = 0x178
               	retq
               	movl	$0x7, %eax
               	addq	$0x178, %rsp            # imm = 0x178
               	retq
               	movl	$0x6, %eax
               	addq	$0x178, %rsp            # imm = 0x178
               	retq
               	movl	$0x5, %eax
               	addq	$0x178, %rsp            # imm = 0x178
               	retq
               	movl	$0x4, %eax
               	addq	$0x178, %rsp            # imm = 0x178
               	retq
               	movl	$0x2, %eax
               	addq	$0x178, %rsp            # imm = 0x178
               	retq
