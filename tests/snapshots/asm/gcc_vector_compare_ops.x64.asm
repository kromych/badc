
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
               	subq	$0x160, %rsp            # imm = 0x160
               	pushq	%rbx
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
               	leaq	0x100(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x138(%rsp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	0x140(%rsp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movups	0x10(%rsp), %xmm0
               	vpcmpeqb	%xmm0, %xmm0, %xmm0
               	movups	%xmm0, 0x110(%rsp)
               	xorl	%eax, %eax
               	movsbq	0x110(%rsp,%rax), %rdx
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
               	popq	%rbx
               	addq	$0x160, %rsp            # imm = 0x160
               	retq
               	movups	0x10(%rsp), %xmm0
               	movups	0x20(%rsp), %xmm1
               	vpcmpeqb	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x110(%rsp)
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	movzbq	0x20(%rsp,%rax), %r8
               	movq	$-0x1, %r9
               	movzbq	0x10(%rsp,%rax), %rbx
               	cmpl	%r8d, %ebx
               	cmovneq	%rcx, %r9
               	movb	%r9b, 0x150(%rsp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x110(%rsp,%rax), %rsi
               	movzbq	0x150(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x110(%rsp), %rcx
               	movzbq	0x10(%rsp), %rax
               	movzbq	0x20(%rsp), %rdx
               	cmpl	%edx, %eax
               	setne	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	negq	%rdx
               	movb	%dl, 0x110(%rsp)
               	movzbq	0x11(%rsp), %rdx
               	movzbq	0x21(%rsp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x111(%rsp)
               	movzbq	0x12(%rsp), %rdx
               	movzbq	0x22(%rsp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x112(%rsp)
               	movzbq	0x13(%rsp), %rdx
               	movzbq	0x23(%rsp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x113(%rsp)
               	movzbq	0x14(%rsp), %rdx
               	movzbq	0x24(%rsp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x114(%rsp)
               	movzbq	0x15(%rsp), %rdx
               	movzbq	0x25(%rsp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x115(%rsp)
               	movzbq	0x16(%rsp), %rdx
               	movzbq	0x26(%rsp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x116(%rsp)
               	movzbq	0x17(%rsp), %rdx
               	movzbq	0x27(%rsp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x117(%rsp)
               	movzbq	0x18(%rsp), %rdx
               	movzbq	0x28(%rsp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x118(%rsp)
               	movzbq	0x19(%rsp), %rdx
               	movzbq	0x29(%rsp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x119(%rsp)
               	movzbq	0x1a(%rsp), %rdx
               	movzbq	0x2a(%rsp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x11a(%rsp)
               	movzbq	0x1b(%rsp), %rdx
               	movzbq	0x2b(%rsp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x11b(%rsp)
               	movzbq	0x1c(%rsp), %rdx
               	movzbq	0x2c(%rsp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x11c(%rsp)
               	movzbq	0x1d(%rsp), %rdx
               	movzbq	0x2d(%rsp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x11d(%rsp)
               	movzbq	0x1e(%rsp), %rdx
               	movzbq	0x2e(%rsp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x11e(%rsp)
               	movzbq	0x1f(%rsp), %rdx
               	movzbq	0x2f(%rsp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x11f(%rsp)
               	leaq	0x120(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movzbq	0x20(%rsp,%rax), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movzbq	0x10(%rsp,%rax), %r8
               	cmpl	%edx, %r8d
               	cmoveq	%rdi, %rsi
               	movb	%sil, 0x150(%rsp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x120(%rsp,%rax), %rsi
               	movzbq	0x150(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x110(%rsp), %rcx
               	movzbq	0x10(%rsp), %rax
               	movzbq	0x20(%rsp), %rdx
               	cmpl	%edx, %eax
               	setb	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	negq	%rdx
               	movb	%dl, 0x110(%rsp)
               	movzbq	0x11(%rsp), %rdx
               	movzbq	0x21(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x111(%rsp)
               	movzbq	0x12(%rsp), %rdx
               	movzbq	0x22(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x112(%rsp)
               	movzbq	0x13(%rsp), %rdx
               	movzbq	0x23(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x113(%rsp)
               	movzbq	0x14(%rsp), %rdx
               	movzbq	0x24(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x114(%rsp)
               	movzbq	0x15(%rsp), %rdx
               	movzbq	0x25(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x115(%rsp)
               	movzbq	0x16(%rsp), %rdx
               	movzbq	0x26(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x116(%rsp)
               	movzbq	0x17(%rsp), %rdx
               	movzbq	0x27(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x117(%rsp)
               	movzbq	0x18(%rsp), %rdx
               	movzbq	0x28(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x118(%rsp)
               	movzbq	0x19(%rsp), %rdx
               	movzbq	0x29(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x119(%rsp)
               	movzbq	0x1a(%rsp), %rdx
               	movzbq	0x2a(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x11a(%rsp)
               	movzbq	0x1b(%rsp), %rdx
               	movzbq	0x2b(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x11b(%rsp)
               	movzbq	0x1c(%rsp), %rdx
               	movzbq	0x2c(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x11c(%rsp)
               	movzbq	0x1d(%rsp), %rdx
               	movzbq	0x2d(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x11d(%rsp)
               	movzbq	0x1e(%rsp), %rdx
               	movzbq	0x2e(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x11e(%rsp)
               	movzbq	0x1f(%rsp), %rdx
               	movzbq	0x2f(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x11f(%rsp)
               	leaq	0x120(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movzbq	0x20(%rsp,%rax), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movzbq	0x10(%rsp,%rax), %r8
               	cmpl	%edx, %r8d
               	cmovgeq	%rdi, %rsi
               	movb	%sil, 0x150(%rsp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x120(%rsp,%rax), %rsi
               	movzbq	0x150(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x110(%rsp), %rcx
               	movzbq	0x10(%rsp), %rax
               	movzbq	0x20(%rsp), %rdx
               	cmpl	%edx, %eax
               	setbe	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	negq	%rdx
               	movb	%dl, 0x110(%rsp)
               	movzbq	0x11(%rsp), %rdx
               	movzbq	0x21(%rsp), %rsi
               	cmpl	%esi, %edx
               	setbe	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x111(%rsp)
               	movzbq	0x12(%rsp), %rdx
               	movzbq	0x22(%rsp), %rsi
               	cmpl	%esi, %edx
               	setbe	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x112(%rsp)
               	movzbq	0x13(%rsp), %rdx
               	movzbq	0x23(%rsp), %rsi
               	cmpl	%esi, %edx
               	setbe	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x113(%rsp)
               	movzbq	0x14(%rsp), %rdx
               	movzbq	0x24(%rsp), %rsi
               	cmpl	%esi, %edx
               	setbe	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x114(%rsp)
               	movzbq	0x15(%rsp), %rdx
               	movzbq	0x25(%rsp), %rsi
               	cmpl	%esi, %edx
               	setbe	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x115(%rsp)
               	movzbq	0x16(%rsp), %rdx
               	movzbq	0x26(%rsp), %rsi
               	cmpl	%esi, %edx
               	setbe	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x116(%rsp)
               	movzbq	0x17(%rsp), %rdx
               	movzbq	0x27(%rsp), %rsi
               	cmpl	%esi, %edx
               	setbe	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x117(%rsp)
               	movzbq	0x18(%rsp), %rdx
               	movzbq	0x28(%rsp), %rsi
               	cmpl	%esi, %edx
               	setbe	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x118(%rsp)
               	movzbq	0x19(%rsp), %rdx
               	movzbq	0x29(%rsp), %rsi
               	cmpl	%esi, %edx
               	setbe	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x119(%rsp)
               	movzbq	0x1a(%rsp), %rdx
               	movzbq	0x2a(%rsp), %rsi
               	cmpl	%esi, %edx
               	setbe	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x11a(%rsp)
               	movzbq	0x1b(%rsp), %rdx
               	movzbq	0x2b(%rsp), %rsi
               	cmpl	%esi, %edx
               	setbe	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x11b(%rsp)
               	movzbq	0x1c(%rsp), %rdx
               	movzbq	0x2c(%rsp), %rsi
               	cmpl	%esi, %edx
               	setbe	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x11c(%rsp)
               	movzbq	0x1d(%rsp), %rdx
               	movzbq	0x2d(%rsp), %rsi
               	cmpl	%esi, %edx
               	setbe	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x11d(%rsp)
               	movzbq	0x1e(%rsp), %rdx
               	movzbq	0x2e(%rsp), %rsi
               	cmpl	%esi, %edx
               	setbe	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x11e(%rsp)
               	movzbq	0x1f(%rsp), %rdx
               	movzbq	0x2f(%rsp), %rsi
               	cmpl	%esi, %edx
               	setbe	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x11f(%rsp)
               	leaq	0x120(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movzbq	0x20(%rsp,%rax), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movzbq	0x10(%rsp,%rax), %r8
               	cmpl	%edx, %r8d
               	cmovgq	%rdi, %rsi
               	movb	%sil, 0x150(%rsp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x120(%rsp,%rax), %rsi
               	movzbq	0x150(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x110(%rsp), %rcx
               	movzbq	0x10(%rsp), %rax
               	movzbq	0x20(%rsp), %rdx
               	cmpl	%edx, %eax
               	seta	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	negq	%rdx
               	movb	%dl, 0x110(%rsp)
               	movzbq	0x11(%rsp), %rdx
               	movzbq	0x21(%rsp), %rsi
               	cmpl	%esi, %edx
               	seta	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x111(%rsp)
               	movzbq	0x12(%rsp), %rdx
               	movzbq	0x22(%rsp), %rsi
               	cmpl	%esi, %edx
               	seta	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x112(%rsp)
               	movzbq	0x13(%rsp), %rdx
               	movzbq	0x23(%rsp), %rsi
               	cmpl	%esi, %edx
               	seta	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x113(%rsp)
               	movzbq	0x14(%rsp), %rdx
               	movzbq	0x24(%rsp), %rsi
               	cmpl	%esi, %edx
               	seta	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x114(%rsp)
               	movzbq	0x15(%rsp), %rdx
               	movzbq	0x25(%rsp), %rsi
               	cmpl	%esi, %edx
               	seta	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x115(%rsp)
               	movzbq	0x16(%rsp), %rdx
               	movzbq	0x26(%rsp), %rsi
               	cmpl	%esi, %edx
               	seta	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x116(%rsp)
               	movzbq	0x17(%rsp), %rdx
               	movzbq	0x27(%rsp), %rsi
               	cmpl	%esi, %edx
               	seta	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x117(%rsp)
               	movzbq	0x18(%rsp), %rdx
               	movzbq	0x28(%rsp), %rsi
               	cmpl	%esi, %edx
               	seta	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x118(%rsp)
               	movzbq	0x19(%rsp), %rdx
               	movzbq	0x29(%rsp), %rsi
               	cmpl	%esi, %edx
               	seta	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x119(%rsp)
               	movzbq	0x1a(%rsp), %rdx
               	movzbq	0x2a(%rsp), %rsi
               	cmpl	%esi, %edx
               	seta	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x11a(%rsp)
               	movzbq	0x1b(%rsp), %rdx
               	movzbq	0x2b(%rsp), %rsi
               	cmpl	%esi, %edx
               	seta	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x11b(%rsp)
               	movzbq	0x1c(%rsp), %rdx
               	movzbq	0x2c(%rsp), %rsi
               	cmpl	%esi, %edx
               	seta	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x11c(%rsp)
               	movzbq	0x1d(%rsp), %rdx
               	movzbq	0x2d(%rsp), %rsi
               	cmpl	%esi, %edx
               	seta	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x11d(%rsp)
               	movzbq	0x1e(%rsp), %rdx
               	movzbq	0x2e(%rsp), %rsi
               	cmpl	%esi, %edx
               	seta	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x11e(%rsp)
               	movzbq	0x1f(%rsp), %rdx
               	movzbq	0x2f(%rsp), %rsi
               	cmpl	%esi, %edx
               	seta	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x11f(%rsp)
               	leaq	0x120(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movzbq	0x20(%rsp,%rax), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movzbq	0x10(%rsp,%rax), %r8
               	cmpl	%edx, %r8d
               	cmovleq	%rdi, %rsi
               	movb	%sil, 0x150(%rsp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x120(%rsp,%rax), %rsi
               	movzbq	0x150(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x110(%rsp), %rcx
               	movzbq	0x10(%rsp), %rax
               	movzbq	0x20(%rsp), %rdx
               	cmpl	%edx, %eax
               	setae	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	negq	%rdx
               	movb	%dl, 0x110(%rsp)
               	movzbq	0x11(%rsp), %rdx
               	movzbq	0x21(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x111(%rsp)
               	movzbq	0x12(%rsp), %rdx
               	movzbq	0x22(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x112(%rsp)
               	movzbq	0x13(%rsp), %rdx
               	movzbq	0x23(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x113(%rsp)
               	movzbq	0x14(%rsp), %rdx
               	movzbq	0x24(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x114(%rsp)
               	movzbq	0x15(%rsp), %rdx
               	movzbq	0x25(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x115(%rsp)
               	movzbq	0x16(%rsp), %rdx
               	movzbq	0x26(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x116(%rsp)
               	movzbq	0x17(%rsp), %rdx
               	movzbq	0x27(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x117(%rsp)
               	movzbq	0x18(%rsp), %rdx
               	movzbq	0x28(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x118(%rsp)
               	movzbq	0x19(%rsp), %rdx
               	movzbq	0x29(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x119(%rsp)
               	movzbq	0x1a(%rsp), %rdx
               	movzbq	0x2a(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x11a(%rsp)
               	movzbq	0x1b(%rsp), %rdx
               	movzbq	0x2b(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x11b(%rsp)
               	movzbq	0x1c(%rsp), %rdx
               	movzbq	0x2c(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x11c(%rsp)
               	movzbq	0x1d(%rsp), %rdx
               	movzbq	0x2d(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x11d(%rsp)
               	movzbq	0x1e(%rsp), %rdx
               	movzbq	0x2e(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x11e(%rsp)
               	movzbq	0x1f(%rsp), %rdx
               	movzbq	0x2f(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x11f(%rsp)
               	leaq	0x120(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movzbq	0x20(%rsp,%rax), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movzbq	0x10(%rsp,%rax), %r8
               	cmpl	%edx, %r8d
               	cmovlq	%rdi, %rsi
               	movb	%sil, 0x150(%rsp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x120(%rsp,%rax), %rsi
               	movzbq	0x150(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	0x30(%rsp), %xmm0
               	movups	0x40(%rsp), %xmm1
               	vpcmpeqb	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x110(%rsp)
               	xorl	%eax, %eax
               	movsbq	0x40(%rsp,%rax), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movsbq	0x30(%rsp,%rax), %r8
               	cmpl	%edx, %r8d
               	cmovneq	%rdi, %rsi
               	movb	%sil, 0x150(%rsp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x110(%rsp,%rax), %rsi
               	movzbq	0x150(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x110(%rsp), %rcx
               	movsbq	0x30(%rsp), %rax
               	movsbq	0x40(%rsp), %rdx
               	cmpl	%edx, %eax
               	setne	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	negq	%rdx
               	movb	%dl, 0x110(%rsp)
               	movsbq	0x31(%rsp), %rdx
               	movsbq	0x41(%rsp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x111(%rsp)
               	movsbq	0x32(%rsp), %rdx
               	movsbq	0x42(%rsp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x112(%rsp)
               	movsbq	0x33(%rsp), %rdx
               	movsbq	0x43(%rsp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x113(%rsp)
               	movsbq	0x34(%rsp), %rdx
               	movsbq	0x44(%rsp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x114(%rsp)
               	movsbq	0x35(%rsp), %rdx
               	movsbq	0x45(%rsp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x115(%rsp)
               	movsbq	0x36(%rsp), %rdx
               	movsbq	0x46(%rsp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x116(%rsp)
               	movsbq	0x37(%rsp), %rdx
               	movsbq	0x47(%rsp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x117(%rsp)
               	movsbq	0x38(%rsp), %rdx
               	movsbq	0x48(%rsp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x118(%rsp)
               	movsbq	0x39(%rsp), %rdx
               	movsbq	0x49(%rsp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x119(%rsp)
               	movsbq	0x3a(%rsp), %rdx
               	movsbq	0x4a(%rsp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x11a(%rsp)
               	movsbq	0x3b(%rsp), %rdx
               	movsbq	0x4b(%rsp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x11b(%rsp)
               	movsbq	0x3c(%rsp), %rdx
               	movsbq	0x4c(%rsp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x11c(%rsp)
               	movsbq	0x3d(%rsp), %rdx
               	movsbq	0x4d(%rsp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x11d(%rsp)
               	movsbq	0x3e(%rsp), %rdx
               	movsbq	0x4e(%rsp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x11e(%rsp)
               	movsbq	0x3f(%rsp), %rdx
               	movsbq	0x4f(%rsp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x11f(%rsp)
               	leaq	0x120(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movsbq	0x40(%rsp,%rax), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movsbq	0x30(%rsp,%rax), %r8
               	cmpl	%edx, %r8d
               	cmoveq	%rdi, %rsi
               	movb	%sil, 0x150(%rsp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x120(%rsp,%rax), %rsi
               	movzbq	0x150(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	0x40(%rsp), %xmm0
               	movups	0x30(%rsp), %xmm1
               	vpcmpgtb	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x110(%rsp)
               	xorl	%eax, %eax
               	movsbq	0x40(%rsp,%rax), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movsbq	0x30(%rsp,%rax), %r8
               	cmpl	%edx, %r8d
               	cmovgeq	%rdi, %rsi
               	movb	%sil, 0x150(%rsp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x110(%rsp,%rax), %rsi
               	movzbq	0x150(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x110(%rsp), %rcx
               	movsbq	0x30(%rsp), %rax
               	movsbq	0x40(%rsp), %rdx
               	cmpl	%edx, %eax
               	setle	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	negq	%rdx
               	movb	%dl, 0x110(%rsp)
               	movsbq	0x31(%rsp), %rdx
               	movsbq	0x41(%rsp), %rsi
               	cmpl	%esi, %edx
               	setle	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x111(%rsp)
               	movsbq	0x32(%rsp), %rdx
               	movsbq	0x42(%rsp), %rsi
               	cmpl	%esi, %edx
               	setle	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x112(%rsp)
               	movsbq	0x33(%rsp), %rdx
               	movsbq	0x43(%rsp), %rsi
               	cmpl	%esi, %edx
               	setle	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x113(%rsp)
               	movsbq	0x34(%rsp), %rdx
               	movsbq	0x44(%rsp), %rsi
               	cmpl	%esi, %edx
               	setle	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x114(%rsp)
               	movsbq	0x35(%rsp), %rdx
               	movsbq	0x45(%rsp), %rsi
               	cmpl	%esi, %edx
               	setle	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x115(%rsp)
               	movsbq	0x36(%rsp), %rdx
               	movsbq	0x46(%rsp), %rsi
               	cmpl	%esi, %edx
               	setle	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x116(%rsp)
               	movsbq	0x37(%rsp), %rdx
               	movsbq	0x47(%rsp), %rsi
               	cmpl	%esi, %edx
               	setle	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x117(%rsp)
               	movsbq	0x38(%rsp), %rdx
               	movsbq	0x48(%rsp), %rsi
               	cmpl	%esi, %edx
               	setle	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x118(%rsp)
               	movsbq	0x39(%rsp), %rdx
               	movsbq	0x49(%rsp), %rsi
               	cmpl	%esi, %edx
               	setle	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x119(%rsp)
               	movsbq	0x3a(%rsp), %rdx
               	movsbq	0x4a(%rsp), %rsi
               	cmpl	%esi, %edx
               	setle	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x11a(%rsp)
               	movsbq	0x3b(%rsp), %rdx
               	movsbq	0x4b(%rsp), %rsi
               	cmpl	%esi, %edx
               	setle	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x11b(%rsp)
               	movsbq	0x3c(%rsp), %rdx
               	movsbq	0x4c(%rsp), %rsi
               	cmpl	%esi, %edx
               	setle	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x11c(%rsp)
               	movsbq	0x3d(%rsp), %rdx
               	movsbq	0x4d(%rsp), %rsi
               	cmpl	%esi, %edx
               	setle	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x11d(%rsp)
               	movsbq	0x3e(%rsp), %rdx
               	movsbq	0x4e(%rsp), %rsi
               	cmpl	%esi, %edx
               	setle	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x11e(%rsp)
               	movsbq	0x3f(%rsp), %rdx
               	movsbq	0x4f(%rsp), %rsi
               	cmpl	%esi, %edx
               	setle	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x11f(%rsp)
               	leaq	0x120(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movsbq	0x40(%rsp,%rax), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movsbq	0x30(%rsp,%rax), %r8
               	cmpl	%edx, %r8d
               	cmovgq	%rdi, %rsi
               	movb	%sil, 0x150(%rsp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x120(%rsp,%rax), %rsi
               	movzbq	0x150(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	0x30(%rsp), %xmm0
               	movups	0x40(%rsp), %xmm1
               	vpcmpgtb	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x110(%rsp)
               	xorl	%eax, %eax
               	movsbq	0x40(%rsp,%rax), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movsbq	0x30(%rsp,%rax), %r8
               	cmpl	%edx, %r8d
               	cmovleq	%rdi, %rsi
               	movb	%sil, 0x150(%rsp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x110(%rsp,%rax), %rsi
               	movzbq	0x150(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x110(%rsp), %rcx
               	movsbq	0x30(%rsp), %rax
               	movsbq	0x40(%rsp), %rdx
               	cmpl	%edx, %eax
               	setge	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	negq	%rdx
               	movb	%dl, 0x110(%rsp)
               	movsbq	0x31(%rsp), %rdx
               	movsbq	0x41(%rsp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x111(%rsp)
               	movsbq	0x32(%rsp), %rdx
               	movsbq	0x42(%rsp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x112(%rsp)
               	movsbq	0x33(%rsp), %rdx
               	movsbq	0x43(%rsp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x113(%rsp)
               	movsbq	0x34(%rsp), %rdx
               	movsbq	0x44(%rsp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x114(%rsp)
               	movsbq	0x35(%rsp), %rdx
               	movsbq	0x45(%rsp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x115(%rsp)
               	movsbq	0x36(%rsp), %rdx
               	movsbq	0x46(%rsp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x116(%rsp)
               	movsbq	0x37(%rsp), %rdx
               	movsbq	0x47(%rsp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x117(%rsp)
               	movsbq	0x38(%rsp), %rdx
               	movsbq	0x48(%rsp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x118(%rsp)
               	movsbq	0x39(%rsp), %rdx
               	movsbq	0x49(%rsp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x119(%rsp)
               	movsbq	0x3a(%rsp), %rdx
               	movsbq	0x4a(%rsp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x11a(%rsp)
               	movsbq	0x3b(%rsp), %rdx
               	movsbq	0x4b(%rsp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x11b(%rsp)
               	movsbq	0x3c(%rsp), %rdx
               	movsbq	0x4c(%rsp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x11c(%rsp)
               	movsbq	0x3d(%rsp), %rdx
               	movsbq	0x4d(%rsp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x11d(%rsp)
               	movsbq	0x3e(%rsp), %rdx
               	movsbq	0x4e(%rsp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x11e(%rsp)
               	movsbq	0x3f(%rsp), %rdx
               	movsbq	0x4f(%rsp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x11f(%rsp)
               	leaq	0x120(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movsbq	0x40(%rsp,%rax), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movsbq	0x30(%rsp,%rax), %r8
               	cmpl	%edx, %r8d
               	cmovlq	%rdi, %rsi
               	movb	%sil, 0x150(%rsp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x120(%rsp,%rax), %rsi
               	movzbq	0x150(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	0x50(%rsp), %xmm0
               	movups	0x60(%rsp), %xmm1
               	vpcmpeqw	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x110(%rsp)
               	xorl	%eax, %eax
               	movzwq	0x60(%rsp,%rax,2), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movzwq	0x50(%rsp,%rax,2), %r8
               	cmpl	%edx, %r8d
               	cmovneq	%rdi, %rsi
               	movw	%si, 0x150(%rsp,%rax,2)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x110(%rsp,%rax), %rsi
               	movzbq	0x150(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x110(%rsp), %rcx
               	movzwq	0x50(%rsp), %rax
               	movzwq	0x60(%rsp), %rdx
               	cmpl	%edx, %eax
               	setb	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	negq	%rdx
               	movw	%dx, 0x110(%rsp)
               	movzwq	0x52(%rsp), %rdx
               	movzwq	0x62(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x112(%rsp)
               	movzwq	0x54(%rsp), %rdx
               	movzwq	0x64(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x114(%rsp)
               	movzwq	0x56(%rsp), %rdx
               	movzwq	0x66(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x116(%rsp)
               	movzwq	0x58(%rsp), %rdx
               	movzwq	0x68(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x118(%rsp)
               	movzwq	0x5a(%rsp), %rdx
               	movzwq	0x6a(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x11a(%rsp)
               	movzwq	0x5c(%rsp), %rdx
               	movzwq	0x6c(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x11c(%rsp)
               	movzwq	0x5e(%rsp), %rdx
               	movzwq	0x6e(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x11e(%rsp)
               	leaq	0x120(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movzwq	0x60(%rsp,%rax,2), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movzwq	0x50(%rsp,%rax,2), %r8
               	cmpl	%edx, %r8d
               	cmovgeq	%rdi, %rsi
               	movw	%si, 0x150(%rsp,%rax,2)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x120(%rsp,%rax), %rsi
               	movzbq	0x150(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x110(%rsp), %rcx
               	movzwq	0x50(%rsp), %rax
               	movzwq	0x60(%rsp), %rdx
               	cmpl	%edx, %eax
               	setae	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	negq	%rdx
               	movw	%dx, 0x110(%rsp)
               	movzwq	0x52(%rsp), %rdx
               	movzwq	0x62(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x112(%rsp)
               	movzwq	0x54(%rsp), %rdx
               	movzwq	0x64(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x114(%rsp)
               	movzwq	0x56(%rsp), %rdx
               	movzwq	0x66(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x116(%rsp)
               	movzwq	0x58(%rsp), %rdx
               	movzwq	0x68(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x118(%rsp)
               	movzwq	0x5a(%rsp), %rdx
               	movzwq	0x6a(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x11a(%rsp)
               	movzwq	0x5c(%rsp), %rdx
               	movzwq	0x6c(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x11c(%rsp)
               	movzwq	0x5e(%rsp), %rdx
               	movzwq	0x6e(%rsp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x11e(%rsp)
               	leaq	0x120(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movzwq	0x60(%rsp,%rax,2), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movzwq	0x50(%rsp,%rax,2), %r8
               	cmpl	%edx, %r8d
               	cmovlq	%rdi, %rsi
               	movw	%si, 0x150(%rsp,%rax,2)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x120(%rsp,%rax), %rsi
               	movzbq	0x150(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x110(%rsp), %rcx
               	movswq	0x70(%rsp), %rax
               	movswq	0x80(%rsp), %rdx
               	cmpl	%edx, %eax
               	setne	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	negq	%rdx
               	movw	%dx, 0x110(%rsp)
               	movswq	0x72(%rsp), %rdx
               	movswq	0x82(%rsp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x112(%rsp)
               	movswq	0x74(%rsp), %rdx
               	movswq	0x84(%rsp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x114(%rsp)
               	movswq	0x76(%rsp), %rdx
               	movswq	0x86(%rsp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x116(%rsp)
               	movswq	0x78(%rsp), %rdx
               	movswq	0x88(%rsp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x118(%rsp)
               	movswq	0x7a(%rsp), %rdx
               	movswq	0x8a(%rsp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x11a(%rsp)
               	movswq	0x7c(%rsp), %rdx
               	movswq	0x8c(%rsp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x11c(%rsp)
               	movswq	0x7e(%rsp), %rdx
               	movswq	0x8e(%rsp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x11e(%rsp)
               	leaq	0x120(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movswq	0x80(%rsp,%rax,2), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movswq	0x70(%rsp,%rax,2), %r8
               	cmpl	%edx, %r8d
               	cmoveq	%rdi, %rsi
               	movw	%si, 0x150(%rsp,%rax,2)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x120(%rsp,%rax), %rsi
               	movzbq	0x150(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x110(%rsp), %rcx
               	movswq	0x70(%rsp), %rax
               	movswq	0x80(%rsp), %rdx
               	cmpl	%edx, %eax
               	setle	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	negq	%rdx
               	movw	%dx, 0x110(%rsp)
               	movswq	0x72(%rsp), %rdx
               	movswq	0x82(%rsp), %rsi
               	cmpl	%esi, %edx
               	setle	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x112(%rsp)
               	movswq	0x74(%rsp), %rdx
               	movswq	0x84(%rsp), %rsi
               	cmpl	%esi, %edx
               	setle	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x114(%rsp)
               	movswq	0x76(%rsp), %rdx
               	movswq	0x86(%rsp), %rsi
               	cmpl	%esi, %edx
               	setle	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x116(%rsp)
               	movswq	0x78(%rsp), %rdx
               	movswq	0x88(%rsp), %rsi
               	cmpl	%esi, %edx
               	setle	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x118(%rsp)
               	movswq	0x7a(%rsp), %rdx
               	movswq	0x8a(%rsp), %rsi
               	cmpl	%esi, %edx
               	setle	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x11a(%rsp)
               	movswq	0x7c(%rsp), %rdx
               	movswq	0x8c(%rsp), %rsi
               	cmpl	%esi, %edx
               	setle	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x11c(%rsp)
               	movswq	0x7e(%rsp), %rdx
               	movswq	0x8e(%rsp), %rsi
               	cmpl	%esi, %edx
               	setle	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, 0x11e(%rsp)
               	leaq	0x120(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movswq	0x80(%rsp,%rax,2), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movswq	0x70(%rsp,%rax,2), %r8
               	cmpl	%edx, %r8d
               	cmovgq	%rdi, %rsi
               	movw	%si, 0x150(%rsp,%rax,2)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x120(%rsp,%rax), %rsi
               	movzbq	0x150(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	0x70(%rsp), %xmm0
               	movups	0x80(%rsp), %xmm1
               	vpcmpgtw	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x110(%rsp)
               	xorl	%eax, %eax
               	movswq	0x80(%rsp,%rax,2), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movswq	0x70(%rsp,%rax,2), %r8
               	cmpl	%edx, %r8d
               	cmovleq	%rdi, %rsi
               	movw	%si, 0x150(%rsp,%rax,2)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x110(%rsp,%rax), %rsi
               	movzbq	0x150(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	0x90(%rsp), %eax
               	movl	0xa0(%rsp), %ecx
               	cmpl	%ecx, %eax
               	setb	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	negq	%rcx
               	movl	0x94(%rsp), %edx
               	movl	0xa4(%rsp), %esi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	0x98(%rsp), %esi
               	movl	0xa8(%rsp), %edi
               	cmpl	%edi, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movl	0x9c(%rsp), %edi
               	movl	0xac(%rsp), %r8d
               	cmpl	%r8d, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movl	%ecx, 0x110(%rsp)
               	movl	%edx, 0x114(%rsp)
               	movl	%esi, 0x118(%rsp)
               	movl	%edi, 0x11c(%rsp)
               	movl	0xa0(%rsp,%rax,4), %edx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movl	0x90(%rsp,%rax,4), %r8d
               	cmpl	%edx, %r8d
               	cmovaeq	%rdi, %rsi
               	movl	%esi, 0x150(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x110(%rsp,%rax), %rsi
               	movzbq	0x150(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	0x90(%rsp), %xmm0
               	movups	0xa0(%rsp), %xmm1
               	vpcmpeqd	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x110(%rsp)
               	xorl	%eax, %eax
               	movl	0xa0(%rsp,%rax,4), %edx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movl	0x90(%rsp,%rax,4), %r8d
               	cmpl	%edx, %r8d
               	cmovneq	%rdi, %rsi
               	movl	%esi, 0x150(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x110(%rsp,%rax), %rsi
               	movzbq	0x150(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	0xc0(%rsp), %xmm0
               	movups	0xb0(%rsp), %xmm1
               	vpcmpgtd	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x110(%rsp)
               	xorl	%eax, %eax
               	movl	0xc0(%rsp,%rax,4), %edx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movl	0xb0(%rsp,%rax,4), %r8d
               	cmpl	%edx, %r8d
               	cmovgeq	%rdi, %rsi
               	movl	%esi, 0x150(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x110(%rsp,%rax), %rsi
               	movzbq	0x150(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	0xb0(%rsp), %eax
               	movl	0xc0(%rsp), %ecx
               	cmpl	%ecx, %eax
               	setge	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	negq	%rcx
               	movl	0xb4(%rsp), %edx
               	movl	0xc4(%rsp), %esi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	0xb8(%rsp), %esi
               	movl	0xc8(%rsp), %edi
               	cmpl	%edi, %esi
               	setge	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movl	0xbc(%rsp), %edi
               	movl	0xcc(%rsp), %r8d
               	cmpl	%r8d, %edi
               	setge	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movl	%ecx, 0x110(%rsp)
               	movl	%edx, 0x114(%rsp)
               	movl	%esi, 0x118(%rsp)
               	movl	%edi, 0x11c(%rsp)
               	movl	0xc0(%rsp,%rax,4), %edx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movl	0xb0(%rsp,%rax,4), %r8d
               	cmpl	%edx, %r8d
               	cmovlq	%rdi, %rsi
               	movl	%esi, 0x150(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x110(%rsp,%rax), %rsi
               	movzbq	0x150(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	0xb0(%rsp), %eax
               	movl	0xc0(%rsp), %ecx
               	cmpl	%ecx, %eax
               	setne	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	negq	%rcx
               	movl	0xb4(%rsp), %edx
               	movl	0xc4(%rsp), %esi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	0xb8(%rsp), %esi
               	movl	0xc8(%rsp), %edi
               	cmpl	%edi, %esi
               	setne	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movl	0xbc(%rsp), %edi
               	movl	0xcc(%rsp), %r8d
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movl	%ecx, 0x110(%rsp)
               	movl	%edx, 0x114(%rsp)
               	movl	%esi, 0x118(%rsp)
               	movl	%edi, 0x11c(%rsp)
               	movl	0xc0(%rsp,%rax,4), %edx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movl	0xb0(%rsp,%rax,4), %r8d
               	cmpl	%edx, %r8d
               	cmoveq	%rdi, %rsi
               	movl	%esi, 0x150(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x110(%rsp,%rax), %rsi
               	movzbq	0x150(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	0xd0(%rsp), %rax
               	movq	0xe0(%rsp), %rdx
               	cmpq	%rdx, %rax
               	setb	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	negq	%rdx
               	movq	0xd8(%rsp), %rsi
               	movq	0xe8(%rsp), %rdi
               	cmpq	%rdi, %rsi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movq	%rdx, 0x110(%rsp)
               	movq	%rsi, 0x118(%rsp)
               	movq	0xe0(%rsp,%rax,8), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movq	0xd0(%rsp,%rax,8), %r8
               	cmpq	%rdx, %r8
               	cmovaeq	%rdi, %rsi
               	movq	%rsi, 0x150(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x110(%rsp,%rax), %rsi
               	movzbq	0x150(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	0xd0(%rsp), %rax
               	movq	0xe0(%rsp), %rdx
               	cmpq	%rdx, %rax
               	seta	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	negq	%rdx
               	movq	0xd8(%rsp), %rsi
               	movq	0xe8(%rsp), %rdi
               	cmpq	%rdi, %rsi
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movq	%rdx, 0x110(%rsp)
               	movq	%rsi, 0x118(%rsp)
               	movq	0xe0(%rsp,%rax,8), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movq	0xd0(%rsp,%rax,8), %r8
               	cmpq	%rdx, %r8
               	cmovbeq	%rdi, %rsi
               	movq	%rsi, 0x150(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x110(%rsp,%rax), %rsi
               	movzbq	0x150(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	0x100(%rsp), %xmm0
               	movups	0xf0(%rsp), %xmm1
               	vpcmpgtq	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x110(%rsp)
               	xorl	%eax, %eax
               	movq	0x100(%rsp,%rax,8), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movq	0xf0(%rsp,%rax,8), %r8
               	cmpq	%rdx, %r8
               	cmovgeq	%rdi, %rsi
               	movq	%rsi, 0x150(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x110(%rsp,%rax), %rsi
               	movzbq	0x150(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	0xf0(%rsp), %xmm0
               	movups	0x100(%rsp), %xmm1
               	vpcmpeqq	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x110(%rsp)
               	xorl	%eax, %eax
               	movq	0x100(%rsp,%rax,8), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movq	0xf0(%rsp,%rax,8), %r8
               	cmpq	%rdx, %r8
               	cmovneq	%rdi, %rsi
               	movq	%rsi, 0x150(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x110(%rsp,%rax), %rsi
               	movzbq	0x150(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x158(%rsp), %rcx
               	movzbq	0x138(%rsp), %rax
               	movzbq	0x140(%rsp), %rdx
               	cmpl	%edx, %eax
               	setb	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	negq	%rdx
               	movb	%dl, 0x158(%rsp)
               	movzbq	0x139(%rsp), %rdx
               	movzbq	0x141(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x159(%rsp)
               	movzbq	0x13a(%rsp), %rdx
               	movzbq	0x142(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x15a(%rsp)
               	movzbq	0x13b(%rsp), %rdx
               	movzbq	0x143(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x15b(%rsp)
               	movzbq	0x13c(%rsp), %rdx
               	movzbq	0x144(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x15c(%rsp)
               	movzbq	0x13d(%rsp), %rdx
               	movzbq	0x145(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x15d(%rsp)
               	movzbq	0x13e(%rsp), %rdx
               	movzbq	0x146(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x15e(%rsp)
               	movzbq	0x13f(%rsp), %rdx
               	movzbq	0x147(%rsp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, 0x15f(%rsp)
               	leaq	0x148(%rsp), %rdx
               	movq	(%rcx), %r10
               	movq	%r10, (%rdx)
               	movzbq	0x140(%rsp,%rax), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movzbq	0x138(%rsp,%rax), %r8
               	cmpl	%edx, %r8d
               	cmovgeq	%rdi, %rsi
               	movb	%sil, 0x158(%rsp,%rax)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x148(%rsp,%rax), %rsi
               	movzbq	0x158(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	0x158(%rsp), %rax
               	leaq	<rip>, %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	leaq	0x100(%rsp), %rcx
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x120(%rsp), %rdx
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movss	0x158(%rsp), %xmm0
               	movss	%xmm0, 0x108(%rsp)
               	movss	0x100(%rsp), %xmm0
               	movss	0x120(%rsp), %xmm1
               	ucomiss	%xmm1, %xmm0
               	sete	%sil
               	movzbq	%sil, %rsi
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rsi
               	xorl	%eax, %eax
               	negq	%rsi
               	movss	0x104(%rsp), %xmm0
               	movss	0x124(%rsp), %xmm1
               	ucomiss	%xmm1, %xmm0
               	sete	%dil
               	movzbq	%dil, %rdi
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rdi
               	negq	%rdi
               	movss	0x108(%rsp), %xmm0
               	movss	0x128(%rsp), %xmm1
               	ucomiss	%xmm1, %xmm0
               	sete	%r8b
               	movzbq	%r8b, %r8
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %r8
               	negq	%r8
               	movss	0x10c(%rsp), %xmm0
               	movss	0x12c(%rsp), %xmm1
               	ucomiss	%xmm1, %xmm0
               	sete	%r9b
               	movzbq	%r9b, %r9
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %r9
               	negq	%r9
               	movl	%esi, 0x110(%rsp)
               	movl	%edi, 0x114(%rsp)
               	movl	%r8d, 0x118(%rsp)
               	movl	%r9d, 0x11c(%rsp)
               	movss	0x120(%rsp,%rax,4), %xmm0
               	movq	$-0x1, %rdi
               	xorl	%r8d, %r8d
               	movss	0x100(%rsp,%rax,4), %xmm1
               	ucomiss	%xmm0, %xmm1
               	cmovneq	%r8, %rdi
               	cmovpq	%r8, %rdi
               	movl	%edi, 0x150(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x110(%rsp,%rax), %rsi
               	movzbq	0x150(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x100(%rsp), %r8
               	leaq	0x120(%rsp), %r9
               	movss	0x100(%rsp), %xmm0
               	movss	0x120(%rsp), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setne	%cl
               	movzbq	%cl, %rcx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rcx
               	xorl	%eax, %eax
               	negq	%rcx
               	movss	0x104(%rsp), %xmm0
               	movss	0x124(%rsp), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setne	%dl
               	movzbq	%dl, %rdx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rdx
               	negq	%rdx
               	movss	0x108(%rsp), %xmm0
               	movss	0x128(%rsp), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setne	%sil
               	movzbq	%sil, %rsi
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rsi
               	negq	%rsi
               	movss	0x10c(%rsp), %xmm0
               	movss	0x12c(%rsp), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setne	%dil
               	movzbq	%dil, %rdi
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rdi
               	negq	%rdi
               	movl	%ecx, 0x110(%rsp)
               	movl	%edx, 0x114(%rsp)
               	movl	%esi, 0x118(%rsp)
               	movl	%edi, 0x11c(%rsp)
               	movss	0x120(%rsp,%rax,4), %xmm0
               	movq	$-0x1, %rdx
               	xorl	%esi, %esi
               	movss	0x100(%rsp,%rax,4), %xmm1
               	ucomiss	%xmm0, %xmm1
               	movq	%rsi, %r10
               	cmovpq	%rdx, %r10
               	cmoveq	%r10, %rdx
               	movl	%edx, 0x150(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x110(%rsp,%rax), %rsi
               	movzbq	0x150(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x100(%rsp), %r8
               	leaq	0x120(%rsp), %r9
               	movss	0x100(%rsp), %xmm0
               	movss	0x120(%rsp), %xmm1
               	comiss	%xmm0, %xmm1
               	seta	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	negq	%rcx
               	movss	0x104(%rsp), %xmm0
               	movss	0x124(%rsp), %xmm1
               	comiss	%xmm0, %xmm1
               	seta	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movss	0x108(%rsp), %xmm0
               	movss	0x128(%rsp), %xmm1
               	comiss	%xmm0, %xmm1
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movss	0x10c(%rsp), %xmm0
               	movss	0x12c(%rsp), %xmm1
               	comiss	%xmm0, %xmm1
               	seta	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movl	%ecx, 0x110(%rsp)
               	movl	%edx, 0x114(%rsp)
               	movl	%esi, 0x118(%rsp)
               	movl	%edi, 0x11c(%rsp)
               	movss	0x120(%rsp,%rax,4), %xmm0
               	movq	$-0x1, %rdx
               	xorl	%esi, %esi
               	movss	0x100(%rsp,%rax,4), %xmm1
               	comiss	%xmm1, %xmm0
               	cmovbeq	%rsi, %rdx
               	movl	%edx, 0x150(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x110(%rsp,%rax), %rsi
               	movzbq	0x150(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x100(%rsp), %r8
               	leaq	0x120(%rsp), %r9
               	movss	0x100(%rsp), %xmm0
               	movss	0x120(%rsp), %xmm1
               	comiss	%xmm0, %xmm1
               	setae	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	negq	%rcx
               	movss	0x104(%rsp), %xmm0
               	movss	0x124(%rsp), %xmm1
               	comiss	%xmm0, %xmm1
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movss	0x108(%rsp), %xmm0
               	movss	0x128(%rsp), %xmm1
               	comiss	%xmm0, %xmm1
               	setae	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movss	0x10c(%rsp), %xmm0
               	movss	0x12c(%rsp), %xmm1
               	comiss	%xmm0, %xmm1
               	setae	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movl	%ecx, 0x110(%rsp)
               	movl	%edx, 0x114(%rsp)
               	movl	%esi, 0x118(%rsp)
               	movl	%edi, 0x11c(%rsp)
               	movss	0x120(%rsp,%rax,4), %xmm0
               	movq	$-0x1, %rdx
               	xorl	%esi, %esi
               	movss	0x100(%rsp,%rax,4), %xmm1
               	comiss	%xmm1, %xmm0
               	cmovbq	%rsi, %rdx
               	movl	%edx, 0x150(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x110(%rsp,%rax), %rsi
               	movzbq	0x150(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x100(%rsp), %r8
               	leaq	0x120(%rsp), %r9
               	movss	0x100(%rsp), %xmm0
               	movss	0x120(%rsp), %xmm1
               	comiss	%xmm1, %xmm0
               	seta	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	negq	%rcx
               	movss	0x104(%rsp), %xmm0
               	movss	0x124(%rsp), %xmm1
               	comiss	%xmm1, %xmm0
               	seta	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movss	0x108(%rsp), %xmm0
               	movss	0x128(%rsp), %xmm1
               	comiss	%xmm1, %xmm0
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movss	0x10c(%rsp), %xmm0
               	movss	0x12c(%rsp), %xmm1
               	comiss	%xmm1, %xmm0
               	seta	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movl	%ecx, 0x110(%rsp)
               	movl	%edx, 0x114(%rsp)
               	movl	%esi, 0x118(%rsp)
               	movl	%edi, 0x11c(%rsp)
               	movss	0x120(%rsp,%rax,4), %xmm0
               	movq	$-0x1, %rdx
               	xorl	%esi, %esi
               	movss	0x100(%rsp,%rax,4), %xmm1
               	comiss	%xmm0, %xmm1
               	cmovbeq	%rsi, %rdx
               	movl	%edx, 0x150(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x110(%rsp,%rax), %rsi
               	movzbq	0x150(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x100(%rsp), %r8
               	leaq	0x120(%rsp), %r9
               	movss	0x100(%rsp), %xmm0
               	movss	0x120(%rsp), %xmm1
               	comiss	%xmm1, %xmm0
               	setae	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	negq	%rcx
               	movss	0x104(%rsp), %xmm0
               	movss	0x124(%rsp), %xmm1
               	comiss	%xmm1, %xmm0
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movss	0x108(%rsp), %xmm0
               	movss	0x128(%rsp), %xmm1
               	comiss	%xmm1, %xmm0
               	setae	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movss	0x10c(%rsp), %xmm0
               	movss	0x12c(%rsp), %xmm1
               	comiss	%xmm1, %xmm0
               	setae	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movl	%ecx, 0x110(%rsp)
               	movl	%edx, 0x114(%rsp)
               	movl	%esi, 0x118(%rsp)
               	movl	%edi, 0x11c(%rsp)
               	movss	0x120(%rsp,%rax,4), %xmm0
               	movq	$-0x1, %rdx
               	xorl	%esi, %esi
               	movss	0x100(%rsp,%rax,4), %xmm1
               	comiss	%xmm0, %xmm1
               	cmovbq	%rsi, %rdx
               	movl	%edx, 0x150(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x110(%rsp,%rax), %rsi
               	movzbq	0x150(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x100(%rsp), %r8
               	movss	0x100(%rsp), %xmm0
               	comiss	<rip>, %xmm0
               	seta	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	negq	%rdx
               	movss	0x104(%rsp), %xmm0
               	comiss	<rip>, %xmm0
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movss	0x108(%rsp), %xmm0
               	comiss	<rip>, %xmm0
               	seta	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movss	0x10c(%rsp), %xmm0
               	comiss	<rip>, %xmm0
               	seta	%r9b
               	movzbq	%r9b, %r9
               	negq	%r9
               	movl	%edx, 0x110(%rsp)
               	movl	%esi, 0x114(%rsp)
               	movl	%edi, 0x118(%rsp)
               	movl	%r9d, 0x11c(%rsp)
               	movq	$-0x1, %rdx
               	xorl	%esi, %esi
               	movss	0x100(%rsp,%rax,4), %xmm0
               	comiss	<rip>, %xmm0
               	cmovbeq	%rsi, %rdx
               	movl	%edx, 0x150(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x110(%rsp,%rax), %rsi
               	movzbq	0x150(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x158(%rsp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	0x100(%rsp), %rcx
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x120(%rsp), %rdx
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movsd	0x158(%rsp), %xmm0
               	movsd	%xmm0, 0x108(%rsp)
               	movsd	0x100(%rsp), %xmm1
               	movsd	0x120(%rsp), %xmm2
               	ucomisd	%xmm2, %xmm1
               	sete	%sil
               	movzbq	%sil, %rsi
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rsi
               	xorl	%eax, %eax
               	negq	%rsi
               	movsd	0x128(%rsp), %xmm1
               	ucomisd	%xmm1, %xmm0
               	sete	%dil
               	movzbq	%dil, %rdi
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rdi
               	negq	%rdi
               	movq	%rsi, 0x110(%rsp)
               	movq	%rdi, 0x118(%rsp)
               	vmovq	0x120(%rsp,%rax,8), %xmm0
               	movq	$-0x1, %rdi
               	xorl	%r8d, %r8d
               	vmovq	0x100(%rsp,%rax,8), %xmm1
               	ucomisd	%xmm0, %xmm1
               	cmovneq	%r8, %rdi
               	cmovpq	%r8, %rdi
               	movq	%rdi, 0x150(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x110(%rsp,%rax), %rsi
               	movzbq	0x150(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movsd	0x100(%rsp), %xmm0
               	movsd	0x120(%rsp), %xmm1
               	ucomisd	%xmm1, %xmm0
               	setne	%dl
               	movzbq	%dl, %rdx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rdx
               	xorl	%eax, %eax
               	negq	%rdx
               	movsd	0x108(%rsp), %xmm0
               	movsd	0x128(%rsp), %xmm1
               	ucomisd	%xmm1, %xmm0
               	setne	%sil
               	movzbq	%sil, %rsi
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rsi
               	negq	%rsi
               	movq	%rdx, 0x110(%rsp)
               	movq	%rsi, 0x118(%rsp)
               	vmovq	0x120(%rsp,%rax,8), %xmm0
               	movq	$-0x1, %rdx
               	xorl	%esi, %esi
               	vmovq	0x100(%rsp,%rax,8), %xmm1
               	ucomisd	%xmm0, %xmm1
               	movq	%rsi, %r10
               	cmovpq	%rdx, %r10
               	cmoveq	%r10, %rdx
               	movq	%rdx, 0x150(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x110(%rsp,%rax), %rsi
               	movzbq	0x150(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movsd	0x100(%rsp), %xmm0
               	movsd	0x120(%rsp), %xmm1
               	comisd	%xmm0, %xmm1
               	seta	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	negq	%rdx
               	movsd	0x108(%rsp), %xmm0
               	movsd	0x128(%rsp), %xmm1
               	comisd	%xmm0, %xmm1
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movq	%rdx, 0x110(%rsp)
               	movq	%rsi, 0x118(%rsp)
               	vmovq	0x120(%rsp,%rax,8), %xmm0
               	movq	$-0x1, %rdx
               	xorl	%esi, %esi
               	vmovq	0x100(%rsp,%rax,8), %xmm1
               	comisd	%xmm1, %xmm0
               	cmovbeq	%rsi, %rdx
               	movq	%rdx, 0x150(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x110(%rsp,%rax), %rsi
               	movzbq	0x150(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x110(%rsp), %rdx
               	movzbq	0x10(%rsp), %rax
               	cmpl	$0x64, %eax
               	seta	%sil
               	movzbq	%sil, %rsi
               	xorl	%eax, %eax
               	negq	%rsi
               	movb	%sil, 0x110(%rsp)
               	movzbq	0x11(%rsp), %rsi
               	cmpl	$0x64, %esi
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x111(%rsp)
               	movzbq	0x12(%rsp), %rsi
               	cmpl	$0x64, %esi
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x112(%rsp)
               	movzbq	0x13(%rsp), %rsi
               	cmpl	$0x64, %esi
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x113(%rsp)
               	movzbq	0x14(%rsp), %rsi
               	cmpl	$0x64, %esi
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x114(%rsp)
               	movzbq	0x15(%rsp), %rsi
               	cmpl	$0x64, %esi
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x115(%rsp)
               	movzbq	0x16(%rsp), %rsi
               	cmpl	$0x64, %esi
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x116(%rsp)
               	movzbq	0x17(%rsp), %rsi
               	cmpl	$0x64, %esi
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x117(%rsp)
               	movzbq	0x18(%rsp), %rsi
               	cmpl	$0x64, %esi
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x118(%rsp)
               	movzbq	0x19(%rsp), %rsi
               	cmpl	$0x64, %esi
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x119(%rsp)
               	movzbq	0x1a(%rsp), %rsi
               	cmpl	$0x64, %esi
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x11a(%rsp)
               	movzbq	0x1b(%rsp), %rsi
               	cmpl	$0x64, %esi
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x11b(%rsp)
               	movzbq	0x1c(%rsp), %rsi
               	cmpl	$0x64, %esi
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x11c(%rsp)
               	movzbq	0x1d(%rsp), %rsi
               	cmpl	$0x64, %esi
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x11d(%rsp)
               	movzbq	0x1e(%rsp), %rsi
               	cmpl	$0x64, %esi
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x11e(%rsp)
               	movzbq	0x1f(%rsp), %rsi
               	cmpl	$0x64, %esi
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x11f(%rsp)
               	leaq	0x120(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movq	$-0x1, %rdx
               	xorl	%esi, %esi
               	movzbq	0x10(%rsp,%rax), %rdi
               	cmpl	$0x64, %edi
               	cmovleq	%rsi, %rdx
               	movb	%dl, 0x150(%rsp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x120(%rsp,%rax), %rsi
               	movzbq	0x150(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x110(%rsp), %rdx
               	movzbq	0x10(%rsp), %rax
               	cmpl	$0x3, %eax
               	sete	%sil
               	movzbq	%sil, %rsi
               	xorl	%eax, %eax
               	negq	%rsi
               	movb	%sil, 0x110(%rsp)
               	movzbq	0x11(%rsp), %rsi
               	cmpl	$0x3, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x111(%rsp)
               	movzbq	0x12(%rsp), %rsi
               	cmpl	$0x3, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x112(%rsp)
               	movzbq	0x13(%rsp), %rsi
               	cmpl	$0x3, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x113(%rsp)
               	movzbq	0x14(%rsp), %rsi
               	cmpl	$0x3, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x114(%rsp)
               	movzbq	0x15(%rsp), %rsi
               	cmpl	$0x3, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x115(%rsp)
               	movzbq	0x16(%rsp), %rsi
               	cmpl	$0x3, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x116(%rsp)
               	movzbq	0x17(%rsp), %rsi
               	cmpl	$0x3, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x117(%rsp)
               	movzbq	0x18(%rsp), %rsi
               	cmpl	$0x3, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x118(%rsp)
               	movzbq	0x19(%rsp), %rsi
               	cmpl	$0x3, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x119(%rsp)
               	movzbq	0x1a(%rsp), %rsi
               	cmpl	$0x3, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x11a(%rsp)
               	movzbq	0x1b(%rsp), %rsi
               	cmpl	$0x3, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x11b(%rsp)
               	movzbq	0x1c(%rsp), %rsi
               	cmpl	$0x3, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x11c(%rsp)
               	movzbq	0x1d(%rsp), %rsi
               	cmpl	$0x3, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x11d(%rsp)
               	movzbq	0x1e(%rsp), %rsi
               	cmpl	$0x3, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x11e(%rsp)
               	movzbq	0x1f(%rsp), %rsi
               	cmpl	$0x3, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x11f(%rsp)
               	leaq	0x120(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movq	$-0x1, %rdx
               	xorl	%esi, %esi
               	movzbq	0x10(%rsp,%rax), %rdi
               	cmpl	$0x3, %edi
               	cmovneq	%rsi, %rdx
               	movb	%dl, 0x150(%rsp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x120(%rsp,%rax), %rsi
               	movzbq	0x150(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x110(%rsp), %rdx
               	movzbq	0x10(%rsp), %rax
               	cmpl	$0xff, %eax
               	setb	%sil
               	movzbq	%sil, %rsi
               	xorl	%eax, %eax
               	negq	%rsi
               	movb	%sil, 0x110(%rsp)
               	movzbq	0x11(%rsp), %rsi
               	cmpl	$0xff, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x111(%rsp)
               	movzbq	0x12(%rsp), %rsi
               	cmpl	$0xff, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x112(%rsp)
               	movzbq	0x13(%rsp), %rsi
               	cmpl	$0xff, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x113(%rsp)
               	movzbq	0x14(%rsp), %rsi
               	cmpl	$0xff, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x114(%rsp)
               	movzbq	0x15(%rsp), %rsi
               	cmpl	$0xff, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x115(%rsp)
               	movzbq	0x16(%rsp), %rsi
               	cmpl	$0xff, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x116(%rsp)
               	movzbq	0x17(%rsp), %rsi
               	cmpl	$0xff, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x117(%rsp)
               	movzbq	0x18(%rsp), %rsi
               	cmpl	$0xff, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x118(%rsp)
               	movzbq	0x19(%rsp), %rsi
               	cmpl	$0xff, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x119(%rsp)
               	movzbq	0x1a(%rsp), %rsi
               	cmpl	$0xff, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x11a(%rsp)
               	movzbq	0x1b(%rsp), %rsi
               	cmpl	$0xff, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x11b(%rsp)
               	movzbq	0x1c(%rsp), %rsi
               	cmpl	$0xff, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x11c(%rsp)
               	movzbq	0x1d(%rsp), %rsi
               	cmpl	$0xff, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x11d(%rsp)
               	movzbq	0x1e(%rsp), %rsi
               	cmpl	$0xff, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x11e(%rsp)
               	movzbq	0x1f(%rsp), %rsi
               	cmpl	$0xff, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x11f(%rsp)
               	leaq	0x120(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movq	$-0x1, %rdx
               	xorl	%esi, %esi
               	movzbq	0x10(%rsp,%rax), %rdi
               	cmpl	$0xff, %edi
               	cmovgeq	%rsi, %rdx
               	movb	%dl, 0x150(%rsp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x120(%rsp,%rax), %rsi
               	movzbq	0x150(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	$-0x5, %rax
               	leaq	0x110(%rsp), %rsi
               	movsbq	0x30(%rsp), %rcx
               	cmpl	%eax, %ecx
               	setg	%dil
               	movzbq	%dil, %rdi
               	xorl	%ecx, %ecx
               	negq	%rdi
               	movb	%dil, 0x110(%rsp)
               	movsbq	0x31(%rsp), %rdi
               	cmpl	%eax, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x111(%rsp)
               	movsbq	0x32(%rsp), %rdi
               	cmpl	%eax, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x112(%rsp)
               	movsbq	0x33(%rsp), %rdi
               	cmpl	%eax, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x113(%rsp)
               	movsbq	0x34(%rsp), %rdi
               	cmpl	%eax, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x114(%rsp)
               	movsbq	0x35(%rsp), %rdi
               	cmpl	%eax, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x115(%rsp)
               	movsbq	0x36(%rsp), %rdi
               	cmpl	%eax, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x116(%rsp)
               	movsbq	0x37(%rsp), %rdi
               	cmpl	%eax, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x117(%rsp)
               	movsbq	0x38(%rsp), %rdi
               	cmpl	%eax, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x118(%rsp)
               	movsbq	0x39(%rsp), %rdi
               	cmpl	%eax, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x119(%rsp)
               	movsbq	0x3a(%rsp), %rdi
               	cmpl	%eax, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x11a(%rsp)
               	movsbq	0x3b(%rsp), %rdi
               	cmpl	%eax, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x11b(%rsp)
               	movsbq	0x3c(%rsp), %rdi
               	cmpl	%eax, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x11c(%rsp)
               	movsbq	0x3d(%rsp), %rdi
               	cmpl	%eax, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x11d(%rsp)
               	movsbq	0x3e(%rsp), %rdi
               	cmpl	%eax, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, 0x11e(%rsp)
               	movsbq	0x3f(%rsp), %rdi
               	cmpl	%eax, %edi
               	setg	%al
               	movzbq	%al, %rax
               	negq	%rax
               	movb	%al, 0x11f(%rsp)
               	leaq	0x120(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	movq	$-0x1, %rax
               	xorl	%esi, %esi
               	movsbq	0x30(%rsp,%rcx), %rdi
               	cmpl	$-0x5, %edi
               	cmovleq	%rsi, %rax
               	movb	%al, 0x150(%rsp,%rcx)
               	incq	%rcx
               	cmpl	$0x10, %ecx
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x120(%rsp,%rax), %rsi
               	movzbq	0x150(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movl	0xb0(%rsp), %edx
               	testl	%edx, %edx
               	setl	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	0xb4(%rsp), %esi
               	testl	%esi, %esi
               	setl	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movl	0xb8(%rsp), %edi
               	testl	%edi, %edi
               	setl	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movl	0xbc(%rsp), %r9d
               	testl	%r9d, %r9d
               	setl	%r9b
               	movzbq	%r9b, %r9
               	negq	%r9
               	movl	%edx, 0x110(%rsp)
               	movl	%esi, 0x114(%rsp)
               	movl	%edi, 0x118(%rsp)
               	movl	%r9d, 0x11c(%rsp)
               	movq	$-0x1, %rdx
               	xorl	%esi, %esi
               	movl	0xb0(%rsp,%rax,4), %edi
               	testl	%edi, %edi
               	cmovgeq	%rsi, %rdx
               	movl	%edx, 0x150(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x110(%rsp,%rax), %rsi
               	movzbq	0x150(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	0xd0(%rsp), %rax
               	cmpq	$0x5, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	negq	%rdx
               	movq	0xd8(%rsp), %rsi
               	cmpq	$0x5, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movq	%rdx, 0x110(%rsp)
               	movq	%rsi, 0x118(%rsp)
               	movq	$-0x1, %rdx
               	xorl	%esi, %esi
               	movq	0xd0(%rsp,%rax,8), %rdi
               	cmpq	$0x5, %rdi
               	cmoveq	%rsi, %rdx
               	movq	%rdx, 0x150(%rsp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x110(%rsp,%rax), %rsi
               	movzbq	0x150(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x110(%rsp), %rdx
               	movzbq	0x10(%rsp), %rax
               	cmpl	$0x64, %eax
               	setb	%sil
               	movzbq	%sil, %rsi
               	xorl	%eax, %eax
               	negq	%rsi
               	movb	%sil, 0x110(%rsp)
               	movzbq	0x11(%rsp), %rsi
               	cmpl	$0x64, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x111(%rsp)
               	movzbq	0x12(%rsp), %rsi
               	cmpl	$0x64, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x112(%rsp)
               	movzbq	0x13(%rsp), %rsi
               	cmpl	$0x64, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x113(%rsp)
               	movzbq	0x14(%rsp), %rsi
               	cmpl	$0x64, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x114(%rsp)
               	movzbq	0x15(%rsp), %rsi
               	cmpl	$0x64, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x115(%rsp)
               	movzbq	0x16(%rsp), %rsi
               	cmpl	$0x64, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x116(%rsp)
               	movzbq	0x17(%rsp), %rsi
               	cmpl	$0x64, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x117(%rsp)
               	movzbq	0x18(%rsp), %rsi
               	cmpl	$0x64, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x118(%rsp)
               	movzbq	0x19(%rsp), %rsi
               	cmpl	$0x64, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x119(%rsp)
               	movzbq	0x1a(%rsp), %rsi
               	cmpl	$0x64, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x11a(%rsp)
               	movzbq	0x1b(%rsp), %rsi
               	cmpl	$0x64, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x11b(%rsp)
               	movzbq	0x1c(%rsp), %rsi
               	cmpl	$0x64, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x11c(%rsp)
               	movzbq	0x1d(%rsp), %rsi
               	cmpl	$0x64, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x11d(%rsp)
               	movzbq	0x1e(%rsp), %rsi
               	cmpl	$0x64, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x11e(%rsp)
               	movzbq	0x1f(%rsp), %rsi
               	cmpl	$0x64, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, 0x11f(%rsp)
               	leaq	0x120(%rsp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movq	$-0x1, %rdx
               	xorl	%esi, %esi
               	movzbq	0x10(%rsp,%rax), %rdi
               	cmpl	$0x64, %edi
               	cmovgeq	%rsi, %rdx
               	movb	%dl, 0x150(%rsp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x120(%rsp,%rax), %rsi
               	movzbq	0x150(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movl	0xb0(%rsp), %edx
               	testl	%edx, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	0xb4(%rsp), %esi
               	testl	%esi, %esi
               	setge	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movl	0xb8(%rsp), %edi
               	testl	%edi, %edi
               	setge	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movl	0xbc(%rsp), %r9d
               	testl	%r9d, %r9d
               	setge	%r9b
               	movzbq	%r9b, %r9
               	negq	%r9
               	movl	%edx, 0x110(%rsp)
               	movl	%esi, 0x114(%rsp)
               	movl	%edi, 0x118(%rsp)
               	movl	%r9d, 0x11c(%rsp)
               	movq	$-0x1, %rdx
               	xorl	%esi, %esi
               	movl	0xb0(%rsp,%rax,4), %edi
               	testl	%edi, %edi
               	cmovlq	%rsi, %rdx
               	movl	%edx, 0x150(%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x110(%rsp,%rax), %rsi
               	movzbq	0x150(%rsp,%rax), %rdi
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
               	popq	%rbx
               	addq	$0x160, %rsp            # imm = 0x160
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	addq	$0x160, %rsp            # imm = 0x160
               	retq
               	movl	$0x31, %eax
               	popq	%rbx
               	addq	$0x160, %rsp            # imm = 0x160
               	retq
               	movl	$0x30, %eax
               	popq	%rbx
               	addq	$0x160, %rsp            # imm = 0x160
               	retq
               	movl	$0x2f, %eax
               	popq	%rbx
               	addq	$0x160, %rsp            # imm = 0x160
               	retq
               	movl	$0x2e, %eax
               	popq	%rbx
               	addq	$0x160, %rsp            # imm = 0x160
               	retq
               	movl	$0x2d, %eax
               	popq	%rbx
               	addq	$0x160, %rsp            # imm = 0x160
               	retq
               	movl	$0x2c, %eax
               	popq	%rbx
               	addq	$0x160, %rsp            # imm = 0x160
               	retq
               	movl	$0x2b, %eax
               	popq	%rbx
               	addq	$0x160, %rsp            # imm = 0x160
               	retq
               	movl	$0x2a, %eax
               	popq	%rbx
               	addq	$0x160, %rsp            # imm = 0x160
               	retq
               	movl	$0x29, %eax
               	popq	%rbx
               	addq	$0x160, %rsp            # imm = 0x160
               	retq
               	movl	$0x28, %eax
               	popq	%rbx
               	addq	$0x160, %rsp            # imm = 0x160
               	retq
               	movl	$0x27, %eax
               	popq	%rbx
               	addq	$0x160, %rsp            # imm = 0x160
               	retq
               	movl	$0x26, %eax
               	popq	%rbx
               	addq	$0x160, %rsp            # imm = 0x160
               	retq
               	movl	$0x25, %eax
               	popq	%rbx
               	addq	$0x160, %rsp            # imm = 0x160
               	retq
               	movl	$0x24, %eax
               	popq	%rbx
               	addq	$0x160, %rsp            # imm = 0x160
               	retq
               	movl	$0x23, %eax
               	popq	%rbx
               	addq	$0x160, %rsp            # imm = 0x160
               	retq
               	movl	$0x22, %eax
               	popq	%rbx
               	addq	$0x160, %rsp            # imm = 0x160
               	retq
               	movl	$0x21, %eax
               	popq	%rbx
               	addq	$0x160, %rsp            # imm = 0x160
               	retq
               	movl	$0x20, %eax
               	popq	%rbx
               	addq	$0x160, %rsp            # imm = 0x160
               	retq
               	movl	$0x1f, %eax
               	popq	%rbx
               	addq	$0x160, %rsp            # imm = 0x160
               	retq
               	movl	$0x1e, %eax
               	popq	%rbx
               	addq	$0x160, %rsp            # imm = 0x160
               	retq
               	movl	$0x1d, %eax
               	popq	%rbx
               	addq	$0x160, %rsp            # imm = 0x160
               	retq
               	movl	$0x1c, %eax
               	popq	%rbx
               	addq	$0x160, %rsp            # imm = 0x160
               	retq
               	movl	$0x1b, %eax
               	popq	%rbx
               	addq	$0x160, %rsp            # imm = 0x160
               	retq
               	movl	$0x1a, %eax
               	popq	%rbx
               	addq	$0x160, %rsp            # imm = 0x160
               	retq
               	movl	$0x19, %eax
               	popq	%rbx
               	addq	$0x160, %rsp            # imm = 0x160
               	retq
               	movl	$0x18, %eax
               	popq	%rbx
               	addq	$0x160, %rsp            # imm = 0x160
               	retq
               	movl	$0x17, %eax
               	popq	%rbx
               	addq	$0x160, %rsp            # imm = 0x160
               	retq
               	movl	$0x16, %eax
               	popq	%rbx
               	addq	$0x160, %rsp            # imm = 0x160
               	retq
               	movl	$0x15, %eax
               	popq	%rbx
               	addq	$0x160, %rsp            # imm = 0x160
               	retq
               	movl	$0x14, %eax
               	popq	%rbx
               	addq	$0x160, %rsp            # imm = 0x160
               	retq
               	movl	$0x13, %eax
               	popq	%rbx
               	addq	$0x160, %rsp            # imm = 0x160
               	retq
               	movl	$0x12, %eax
               	popq	%rbx
               	addq	$0x160, %rsp            # imm = 0x160
               	retq
               	movl	$0x11, %eax
               	popq	%rbx
               	addq	$0x160, %rsp            # imm = 0x160
               	retq
               	movl	$0x10, %eax
               	popq	%rbx
               	addq	$0x160, %rsp            # imm = 0x160
               	retq
               	movl	$0xf, %eax
               	popq	%rbx
               	addq	$0x160, %rsp            # imm = 0x160
               	retq
               	movl	$0xe, %eax
               	popq	%rbx
               	addq	$0x160, %rsp            # imm = 0x160
               	retq
               	movl	$0xd, %eax
               	popq	%rbx
               	addq	$0x160, %rsp            # imm = 0x160
               	retq
               	movl	$0xc, %eax
               	popq	%rbx
               	addq	$0x160, %rsp            # imm = 0x160
               	retq
               	movl	$0xb, %eax
               	popq	%rbx
               	addq	$0x160, %rsp            # imm = 0x160
               	retq
               	movl	$0xa, %eax
               	popq	%rbx
               	addq	$0x160, %rsp            # imm = 0x160
               	retq
               	movl	$0x9, %eax
               	popq	%rbx
               	addq	$0x160, %rsp            # imm = 0x160
               	retq
               	movl	$0x8, %eax
               	popq	%rbx
               	addq	$0x160, %rsp            # imm = 0x160
               	retq
               	movl	$0x7, %eax
               	popq	%rbx
               	addq	$0x160, %rsp            # imm = 0x160
               	retq
               	movl	$0x6, %eax
               	popq	%rbx
               	addq	$0x160, %rsp            # imm = 0x160
               	retq
               	movl	$0x5, %eax
               	popq	%rbx
               	addq	$0x160, %rsp            # imm = 0x160
               	retq
               	movl	$0x4, %eax
               	popq	%rbx
               	addq	$0x160, %rsp            # imm = 0x160
               	retq
               	movl	$0x2, %eax
               	popq	%rbx
               	addq	$0x160, %rsp            # imm = 0x160
               	retq
