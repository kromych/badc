
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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x158, %rsp            # imm = 0x158
               	pushq	%rbx
               	leaq	-0x150(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x140(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x130(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x120(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x110(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x100(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xf0(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xe0(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xd0(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xc0(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xb0(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xa0(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x90(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x80(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x70(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x60(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x28(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x20(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movups	-0x150(%rbp), %xmm0
               	vpcmpeqb	%xmm0, %xmm0, %xmm0
               	movups	%xmm0, -0x50(%rbp)
               	xorl	%eax, %eax
               	movsbq	-0x50(%rbp,%rax), %rdx
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
               	leave
               	retq
               	movups	-0x150(%rbp), %xmm0
               	movups	-0x140(%rbp), %xmm1
               	vpcmpeqb	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, -0x50(%rbp)
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	movzbq	-0x140(%rbp,%rax), %r8
               	movq	$-0x1, %r9
               	movzbq	-0x150(%rbp,%rax), %rbx
               	cmpl	%r8d, %ebx
               	cmovneq	%rcx, %r9
               	movb	%r9b, -0x10(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	-0x50(%rbp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rcx
               	movzbq	-0x150(%rbp), %rax
               	movzbq	-0x140(%rbp), %rdx
               	cmpl	%edx, %eax
               	setne	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	negq	%rdx
               	movb	%dl, -0x50(%rbp)
               	movzbq	-0x14f(%rbp), %rdx
               	movzbq	-0x13f(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x4f(%rbp)
               	movzbq	-0x14e(%rbp), %rdx
               	movzbq	-0x13e(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x4e(%rbp)
               	movzbq	-0x14d(%rbp), %rdx
               	movzbq	-0x13d(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x4d(%rbp)
               	movzbq	-0x14c(%rbp), %rdx
               	movzbq	-0x13c(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x4c(%rbp)
               	movzbq	-0x14b(%rbp), %rdx
               	movzbq	-0x13b(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x4b(%rbp)
               	movzbq	-0x14a(%rbp), %rdx
               	movzbq	-0x13a(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x4a(%rbp)
               	movzbq	-0x149(%rbp), %rdx
               	movzbq	-0x139(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x49(%rbp)
               	movzbq	-0x148(%rbp), %rdx
               	movzbq	-0x138(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x48(%rbp)
               	movzbq	-0x147(%rbp), %rdx
               	movzbq	-0x137(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x47(%rbp)
               	movzbq	-0x146(%rbp), %rdx
               	movzbq	-0x136(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x46(%rbp)
               	movzbq	-0x145(%rbp), %rdx
               	movzbq	-0x135(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x45(%rbp)
               	movzbq	-0x144(%rbp), %rdx
               	movzbq	-0x134(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x44(%rbp)
               	movzbq	-0x143(%rbp), %rdx
               	movzbq	-0x133(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x43(%rbp)
               	movzbq	-0x142(%rbp), %rdx
               	movzbq	-0x132(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x42(%rbp)
               	movzbq	-0x141(%rbp), %rdx
               	movzbq	-0x131(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x41(%rbp)
               	leaq	-0x40(%rbp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movzbq	-0x140(%rbp,%rax), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movzbq	-0x150(%rbp,%rax), %r8
               	cmpl	%edx, %r8d
               	cmoveq	%rdi, %rsi
               	movb	%sil, -0x10(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	-0x40(%rbp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rcx
               	movzbq	-0x150(%rbp), %rax
               	movzbq	-0x140(%rbp), %rdx
               	cmpl	%edx, %eax
               	setb	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	negq	%rdx
               	movb	%dl, -0x50(%rbp)
               	movzbq	-0x14f(%rbp), %rdx
               	movzbq	-0x13f(%rbp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x4f(%rbp)
               	movzbq	-0x14e(%rbp), %rdx
               	movzbq	-0x13e(%rbp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x4e(%rbp)
               	movzbq	-0x14d(%rbp), %rdx
               	movzbq	-0x13d(%rbp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x4d(%rbp)
               	movzbq	-0x14c(%rbp), %rdx
               	movzbq	-0x13c(%rbp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x4c(%rbp)
               	movzbq	-0x14b(%rbp), %rdx
               	movzbq	-0x13b(%rbp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x4b(%rbp)
               	movzbq	-0x14a(%rbp), %rdx
               	movzbq	-0x13a(%rbp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x4a(%rbp)
               	movzbq	-0x149(%rbp), %rdx
               	movzbq	-0x139(%rbp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x49(%rbp)
               	movzbq	-0x148(%rbp), %rdx
               	movzbq	-0x138(%rbp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x48(%rbp)
               	movzbq	-0x147(%rbp), %rdx
               	movzbq	-0x137(%rbp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x47(%rbp)
               	movzbq	-0x146(%rbp), %rdx
               	movzbq	-0x136(%rbp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x46(%rbp)
               	movzbq	-0x145(%rbp), %rdx
               	movzbq	-0x135(%rbp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x45(%rbp)
               	movzbq	-0x144(%rbp), %rdx
               	movzbq	-0x134(%rbp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x44(%rbp)
               	movzbq	-0x143(%rbp), %rdx
               	movzbq	-0x133(%rbp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x43(%rbp)
               	movzbq	-0x142(%rbp), %rdx
               	movzbq	-0x132(%rbp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x42(%rbp)
               	movzbq	-0x141(%rbp), %rdx
               	movzbq	-0x131(%rbp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x41(%rbp)
               	leaq	-0x40(%rbp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movzbq	-0x140(%rbp,%rax), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movzbq	-0x150(%rbp,%rax), %r8
               	cmpl	%edx, %r8d
               	cmovgeq	%rdi, %rsi
               	movb	%sil, -0x10(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	-0x40(%rbp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rcx
               	movzbq	-0x150(%rbp), %rax
               	movzbq	-0x140(%rbp), %rdx
               	cmpl	%edx, %eax
               	setbe	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	negq	%rdx
               	movb	%dl, -0x50(%rbp)
               	movzbq	-0x14f(%rbp), %rdx
               	movzbq	-0x13f(%rbp), %rsi
               	cmpl	%esi, %edx
               	setbe	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x4f(%rbp)
               	movzbq	-0x14e(%rbp), %rdx
               	movzbq	-0x13e(%rbp), %rsi
               	cmpl	%esi, %edx
               	setbe	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x4e(%rbp)
               	movzbq	-0x14d(%rbp), %rdx
               	movzbq	-0x13d(%rbp), %rsi
               	cmpl	%esi, %edx
               	setbe	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x4d(%rbp)
               	movzbq	-0x14c(%rbp), %rdx
               	movzbq	-0x13c(%rbp), %rsi
               	cmpl	%esi, %edx
               	setbe	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x4c(%rbp)
               	movzbq	-0x14b(%rbp), %rdx
               	movzbq	-0x13b(%rbp), %rsi
               	cmpl	%esi, %edx
               	setbe	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x4b(%rbp)
               	movzbq	-0x14a(%rbp), %rdx
               	movzbq	-0x13a(%rbp), %rsi
               	cmpl	%esi, %edx
               	setbe	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x4a(%rbp)
               	movzbq	-0x149(%rbp), %rdx
               	movzbq	-0x139(%rbp), %rsi
               	cmpl	%esi, %edx
               	setbe	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x49(%rbp)
               	movzbq	-0x148(%rbp), %rdx
               	movzbq	-0x138(%rbp), %rsi
               	cmpl	%esi, %edx
               	setbe	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x48(%rbp)
               	movzbq	-0x147(%rbp), %rdx
               	movzbq	-0x137(%rbp), %rsi
               	cmpl	%esi, %edx
               	setbe	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x47(%rbp)
               	movzbq	-0x146(%rbp), %rdx
               	movzbq	-0x136(%rbp), %rsi
               	cmpl	%esi, %edx
               	setbe	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x46(%rbp)
               	movzbq	-0x145(%rbp), %rdx
               	movzbq	-0x135(%rbp), %rsi
               	cmpl	%esi, %edx
               	setbe	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x45(%rbp)
               	movzbq	-0x144(%rbp), %rdx
               	movzbq	-0x134(%rbp), %rsi
               	cmpl	%esi, %edx
               	setbe	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x44(%rbp)
               	movzbq	-0x143(%rbp), %rdx
               	movzbq	-0x133(%rbp), %rsi
               	cmpl	%esi, %edx
               	setbe	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x43(%rbp)
               	movzbq	-0x142(%rbp), %rdx
               	movzbq	-0x132(%rbp), %rsi
               	cmpl	%esi, %edx
               	setbe	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x42(%rbp)
               	movzbq	-0x141(%rbp), %rdx
               	movzbq	-0x131(%rbp), %rsi
               	cmpl	%esi, %edx
               	setbe	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x41(%rbp)
               	leaq	-0x40(%rbp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movzbq	-0x140(%rbp,%rax), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movzbq	-0x150(%rbp,%rax), %r8
               	cmpl	%edx, %r8d
               	cmovgq	%rdi, %rsi
               	movb	%sil, -0x10(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	-0x40(%rbp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rcx
               	movzbq	-0x150(%rbp), %rax
               	movzbq	-0x140(%rbp), %rdx
               	cmpl	%edx, %eax
               	seta	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	negq	%rdx
               	movb	%dl, -0x50(%rbp)
               	movzbq	-0x14f(%rbp), %rdx
               	movzbq	-0x13f(%rbp), %rsi
               	cmpl	%esi, %edx
               	seta	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x4f(%rbp)
               	movzbq	-0x14e(%rbp), %rdx
               	movzbq	-0x13e(%rbp), %rsi
               	cmpl	%esi, %edx
               	seta	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x4e(%rbp)
               	movzbq	-0x14d(%rbp), %rdx
               	movzbq	-0x13d(%rbp), %rsi
               	cmpl	%esi, %edx
               	seta	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x4d(%rbp)
               	movzbq	-0x14c(%rbp), %rdx
               	movzbq	-0x13c(%rbp), %rsi
               	cmpl	%esi, %edx
               	seta	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x4c(%rbp)
               	movzbq	-0x14b(%rbp), %rdx
               	movzbq	-0x13b(%rbp), %rsi
               	cmpl	%esi, %edx
               	seta	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x4b(%rbp)
               	movzbq	-0x14a(%rbp), %rdx
               	movzbq	-0x13a(%rbp), %rsi
               	cmpl	%esi, %edx
               	seta	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x4a(%rbp)
               	movzbq	-0x149(%rbp), %rdx
               	movzbq	-0x139(%rbp), %rsi
               	cmpl	%esi, %edx
               	seta	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x49(%rbp)
               	movzbq	-0x148(%rbp), %rdx
               	movzbq	-0x138(%rbp), %rsi
               	cmpl	%esi, %edx
               	seta	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x48(%rbp)
               	movzbq	-0x147(%rbp), %rdx
               	movzbq	-0x137(%rbp), %rsi
               	cmpl	%esi, %edx
               	seta	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x47(%rbp)
               	movzbq	-0x146(%rbp), %rdx
               	movzbq	-0x136(%rbp), %rsi
               	cmpl	%esi, %edx
               	seta	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x46(%rbp)
               	movzbq	-0x145(%rbp), %rdx
               	movzbq	-0x135(%rbp), %rsi
               	cmpl	%esi, %edx
               	seta	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x45(%rbp)
               	movzbq	-0x144(%rbp), %rdx
               	movzbq	-0x134(%rbp), %rsi
               	cmpl	%esi, %edx
               	seta	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x44(%rbp)
               	movzbq	-0x143(%rbp), %rdx
               	movzbq	-0x133(%rbp), %rsi
               	cmpl	%esi, %edx
               	seta	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x43(%rbp)
               	movzbq	-0x142(%rbp), %rdx
               	movzbq	-0x132(%rbp), %rsi
               	cmpl	%esi, %edx
               	seta	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x42(%rbp)
               	movzbq	-0x141(%rbp), %rdx
               	movzbq	-0x131(%rbp), %rsi
               	cmpl	%esi, %edx
               	seta	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x41(%rbp)
               	leaq	-0x40(%rbp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movzbq	-0x140(%rbp,%rax), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movzbq	-0x150(%rbp,%rax), %r8
               	cmpl	%edx, %r8d
               	cmovleq	%rdi, %rsi
               	movb	%sil, -0x10(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	-0x40(%rbp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rcx
               	movzbq	-0x150(%rbp), %rax
               	movzbq	-0x140(%rbp), %rdx
               	cmpl	%edx, %eax
               	setae	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	negq	%rdx
               	movb	%dl, -0x50(%rbp)
               	movzbq	-0x14f(%rbp), %rdx
               	movzbq	-0x13f(%rbp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x4f(%rbp)
               	movzbq	-0x14e(%rbp), %rdx
               	movzbq	-0x13e(%rbp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x4e(%rbp)
               	movzbq	-0x14d(%rbp), %rdx
               	movzbq	-0x13d(%rbp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x4d(%rbp)
               	movzbq	-0x14c(%rbp), %rdx
               	movzbq	-0x13c(%rbp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x4c(%rbp)
               	movzbq	-0x14b(%rbp), %rdx
               	movzbq	-0x13b(%rbp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x4b(%rbp)
               	movzbq	-0x14a(%rbp), %rdx
               	movzbq	-0x13a(%rbp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x4a(%rbp)
               	movzbq	-0x149(%rbp), %rdx
               	movzbq	-0x139(%rbp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x49(%rbp)
               	movzbq	-0x148(%rbp), %rdx
               	movzbq	-0x138(%rbp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x48(%rbp)
               	movzbq	-0x147(%rbp), %rdx
               	movzbq	-0x137(%rbp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x47(%rbp)
               	movzbq	-0x146(%rbp), %rdx
               	movzbq	-0x136(%rbp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x46(%rbp)
               	movzbq	-0x145(%rbp), %rdx
               	movzbq	-0x135(%rbp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x45(%rbp)
               	movzbq	-0x144(%rbp), %rdx
               	movzbq	-0x134(%rbp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x44(%rbp)
               	movzbq	-0x143(%rbp), %rdx
               	movzbq	-0x133(%rbp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x43(%rbp)
               	movzbq	-0x142(%rbp), %rdx
               	movzbq	-0x132(%rbp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x42(%rbp)
               	movzbq	-0x141(%rbp), %rdx
               	movzbq	-0x131(%rbp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x41(%rbp)
               	leaq	-0x40(%rbp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movzbq	-0x140(%rbp,%rax), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movzbq	-0x150(%rbp,%rax), %r8
               	cmpl	%edx, %r8d
               	cmovlq	%rdi, %rsi
               	movb	%sil, -0x10(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	-0x40(%rbp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	-0x130(%rbp), %xmm0
               	movups	-0x120(%rbp), %xmm1
               	vpcmpeqb	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, -0x50(%rbp)
               	xorl	%eax, %eax
               	movsbq	-0x120(%rbp,%rax), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movsbq	-0x130(%rbp,%rax), %r8
               	cmpl	%edx, %r8d
               	cmovneq	%rdi, %rsi
               	movb	%sil, -0x10(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	-0x50(%rbp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rcx
               	movsbq	-0x130(%rbp), %rax
               	movsbq	-0x120(%rbp), %rdx
               	cmpl	%edx, %eax
               	setne	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	negq	%rdx
               	movb	%dl, -0x50(%rbp)
               	movsbq	-0x12f(%rbp), %rdx
               	movsbq	-0x11f(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x4f(%rbp)
               	movsbq	-0x12e(%rbp), %rdx
               	movsbq	-0x11e(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x4e(%rbp)
               	movsbq	-0x12d(%rbp), %rdx
               	movsbq	-0x11d(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x4d(%rbp)
               	movsbq	-0x12c(%rbp), %rdx
               	movsbq	-0x11c(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x4c(%rbp)
               	movsbq	-0x12b(%rbp), %rdx
               	movsbq	-0x11b(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x4b(%rbp)
               	movsbq	-0x12a(%rbp), %rdx
               	movsbq	-0x11a(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x4a(%rbp)
               	movsbq	-0x129(%rbp), %rdx
               	movsbq	-0x119(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x49(%rbp)
               	movsbq	-0x128(%rbp), %rdx
               	movsbq	-0x118(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x48(%rbp)
               	movsbq	-0x127(%rbp), %rdx
               	movsbq	-0x117(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x47(%rbp)
               	movsbq	-0x126(%rbp), %rdx
               	movsbq	-0x116(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x46(%rbp)
               	movsbq	-0x125(%rbp), %rdx
               	movsbq	-0x115(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x45(%rbp)
               	movsbq	-0x124(%rbp), %rdx
               	movsbq	-0x114(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x44(%rbp)
               	movsbq	-0x123(%rbp), %rdx
               	movsbq	-0x113(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x43(%rbp)
               	movsbq	-0x122(%rbp), %rdx
               	movsbq	-0x112(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x42(%rbp)
               	movsbq	-0x121(%rbp), %rdx
               	movsbq	-0x111(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x41(%rbp)
               	leaq	-0x40(%rbp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movsbq	-0x120(%rbp,%rax), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movsbq	-0x130(%rbp,%rax), %r8
               	cmpl	%edx, %r8d
               	cmoveq	%rdi, %rsi
               	movb	%sil, -0x10(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	-0x40(%rbp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	-0x120(%rbp), %xmm0
               	movups	-0x130(%rbp), %xmm1
               	vpcmpgtb	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, -0x50(%rbp)
               	xorl	%eax, %eax
               	movsbq	-0x120(%rbp,%rax), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movsbq	-0x130(%rbp,%rax), %r8
               	cmpl	%edx, %r8d
               	cmovgeq	%rdi, %rsi
               	movb	%sil, -0x10(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	-0x50(%rbp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rcx
               	movsbq	-0x130(%rbp), %rax
               	movsbq	-0x120(%rbp), %rdx
               	cmpl	%edx, %eax
               	setle	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	negq	%rdx
               	movb	%dl, -0x50(%rbp)
               	movsbq	-0x12f(%rbp), %rdx
               	movsbq	-0x11f(%rbp), %rsi
               	cmpl	%esi, %edx
               	setle	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x4f(%rbp)
               	movsbq	-0x12e(%rbp), %rdx
               	movsbq	-0x11e(%rbp), %rsi
               	cmpl	%esi, %edx
               	setle	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x4e(%rbp)
               	movsbq	-0x12d(%rbp), %rdx
               	movsbq	-0x11d(%rbp), %rsi
               	cmpl	%esi, %edx
               	setle	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x4d(%rbp)
               	movsbq	-0x12c(%rbp), %rdx
               	movsbq	-0x11c(%rbp), %rsi
               	cmpl	%esi, %edx
               	setle	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x4c(%rbp)
               	movsbq	-0x12b(%rbp), %rdx
               	movsbq	-0x11b(%rbp), %rsi
               	cmpl	%esi, %edx
               	setle	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x4b(%rbp)
               	movsbq	-0x12a(%rbp), %rdx
               	movsbq	-0x11a(%rbp), %rsi
               	cmpl	%esi, %edx
               	setle	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x4a(%rbp)
               	movsbq	-0x129(%rbp), %rdx
               	movsbq	-0x119(%rbp), %rsi
               	cmpl	%esi, %edx
               	setle	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x49(%rbp)
               	movsbq	-0x128(%rbp), %rdx
               	movsbq	-0x118(%rbp), %rsi
               	cmpl	%esi, %edx
               	setle	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x48(%rbp)
               	movsbq	-0x127(%rbp), %rdx
               	movsbq	-0x117(%rbp), %rsi
               	cmpl	%esi, %edx
               	setle	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x47(%rbp)
               	movsbq	-0x126(%rbp), %rdx
               	movsbq	-0x116(%rbp), %rsi
               	cmpl	%esi, %edx
               	setle	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x46(%rbp)
               	movsbq	-0x125(%rbp), %rdx
               	movsbq	-0x115(%rbp), %rsi
               	cmpl	%esi, %edx
               	setle	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x45(%rbp)
               	movsbq	-0x124(%rbp), %rdx
               	movsbq	-0x114(%rbp), %rsi
               	cmpl	%esi, %edx
               	setle	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x44(%rbp)
               	movsbq	-0x123(%rbp), %rdx
               	movsbq	-0x113(%rbp), %rsi
               	cmpl	%esi, %edx
               	setle	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x43(%rbp)
               	movsbq	-0x122(%rbp), %rdx
               	movsbq	-0x112(%rbp), %rsi
               	cmpl	%esi, %edx
               	setle	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x42(%rbp)
               	movsbq	-0x121(%rbp), %rdx
               	movsbq	-0x111(%rbp), %rsi
               	cmpl	%esi, %edx
               	setle	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x41(%rbp)
               	leaq	-0x40(%rbp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movsbq	-0x120(%rbp,%rax), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movsbq	-0x130(%rbp,%rax), %r8
               	cmpl	%edx, %r8d
               	cmovgq	%rdi, %rsi
               	movb	%sil, -0x10(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	-0x40(%rbp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	-0x130(%rbp), %xmm0
               	movups	-0x120(%rbp), %xmm1
               	vpcmpgtb	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, -0x50(%rbp)
               	xorl	%eax, %eax
               	movsbq	-0x120(%rbp,%rax), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movsbq	-0x130(%rbp,%rax), %r8
               	cmpl	%edx, %r8d
               	cmovleq	%rdi, %rsi
               	movb	%sil, -0x10(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	-0x50(%rbp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rcx
               	movsbq	-0x130(%rbp), %rax
               	movsbq	-0x120(%rbp), %rdx
               	cmpl	%edx, %eax
               	setge	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	negq	%rdx
               	movb	%dl, -0x50(%rbp)
               	movsbq	-0x12f(%rbp), %rdx
               	movsbq	-0x11f(%rbp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x4f(%rbp)
               	movsbq	-0x12e(%rbp), %rdx
               	movsbq	-0x11e(%rbp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x4e(%rbp)
               	movsbq	-0x12d(%rbp), %rdx
               	movsbq	-0x11d(%rbp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x4d(%rbp)
               	movsbq	-0x12c(%rbp), %rdx
               	movsbq	-0x11c(%rbp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x4c(%rbp)
               	movsbq	-0x12b(%rbp), %rdx
               	movsbq	-0x11b(%rbp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x4b(%rbp)
               	movsbq	-0x12a(%rbp), %rdx
               	movsbq	-0x11a(%rbp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x4a(%rbp)
               	movsbq	-0x129(%rbp), %rdx
               	movsbq	-0x119(%rbp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x49(%rbp)
               	movsbq	-0x128(%rbp), %rdx
               	movsbq	-0x118(%rbp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x48(%rbp)
               	movsbq	-0x127(%rbp), %rdx
               	movsbq	-0x117(%rbp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x47(%rbp)
               	movsbq	-0x126(%rbp), %rdx
               	movsbq	-0x116(%rbp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x46(%rbp)
               	movsbq	-0x125(%rbp), %rdx
               	movsbq	-0x115(%rbp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x45(%rbp)
               	movsbq	-0x124(%rbp), %rdx
               	movsbq	-0x114(%rbp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x44(%rbp)
               	movsbq	-0x123(%rbp), %rdx
               	movsbq	-0x113(%rbp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x43(%rbp)
               	movsbq	-0x122(%rbp), %rdx
               	movsbq	-0x112(%rbp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x42(%rbp)
               	movsbq	-0x121(%rbp), %rdx
               	movsbq	-0x111(%rbp), %rsi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x41(%rbp)
               	leaq	-0x40(%rbp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movsbq	-0x120(%rbp,%rax), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movsbq	-0x130(%rbp,%rax), %r8
               	cmpl	%edx, %r8d
               	cmovlq	%rdi, %rsi
               	movb	%sil, -0x10(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	-0x40(%rbp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	-0x110(%rbp), %xmm0
               	movups	-0x100(%rbp), %xmm1
               	vpcmpeqw	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, -0x50(%rbp)
               	xorl	%eax, %eax
               	movzwq	-0x100(%rbp,%rax,2), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movzwq	-0x110(%rbp,%rax,2), %r8
               	cmpl	%edx, %r8d
               	cmovneq	%rdi, %rsi
               	movw	%si, -0x10(%rbp,%rax,2)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	-0x50(%rbp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rcx
               	movzwq	-0x110(%rbp), %rax
               	movzwq	-0x100(%rbp), %rdx
               	cmpl	%edx, %eax
               	setb	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	negq	%rdx
               	movw	%dx, -0x50(%rbp)
               	movzwq	-0x10e(%rbp), %rdx
               	movzwq	-0xfe(%rbp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x4e(%rbp)
               	movzwq	-0x10c(%rbp), %rdx
               	movzwq	-0xfc(%rbp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x4c(%rbp)
               	movzwq	-0x10a(%rbp), %rdx
               	movzwq	-0xfa(%rbp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x4a(%rbp)
               	movzwq	-0x108(%rbp), %rdx
               	movzwq	-0xf8(%rbp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x48(%rbp)
               	movzwq	-0x106(%rbp), %rdx
               	movzwq	-0xf6(%rbp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x46(%rbp)
               	movzwq	-0x104(%rbp), %rdx
               	movzwq	-0xf4(%rbp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x44(%rbp)
               	movzwq	-0x102(%rbp), %rdx
               	movzwq	-0xf2(%rbp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x42(%rbp)
               	leaq	-0x40(%rbp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movzwq	-0x100(%rbp,%rax,2), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movzwq	-0x110(%rbp,%rax,2), %r8
               	cmpl	%edx, %r8d
               	cmovgeq	%rdi, %rsi
               	movw	%si, -0x10(%rbp,%rax,2)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	-0x40(%rbp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rcx
               	movzwq	-0x110(%rbp), %rax
               	movzwq	-0x100(%rbp), %rdx
               	cmpl	%edx, %eax
               	setae	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	negq	%rdx
               	movw	%dx, -0x50(%rbp)
               	movzwq	-0x10e(%rbp), %rdx
               	movzwq	-0xfe(%rbp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x4e(%rbp)
               	movzwq	-0x10c(%rbp), %rdx
               	movzwq	-0xfc(%rbp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x4c(%rbp)
               	movzwq	-0x10a(%rbp), %rdx
               	movzwq	-0xfa(%rbp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x4a(%rbp)
               	movzwq	-0x108(%rbp), %rdx
               	movzwq	-0xf8(%rbp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x48(%rbp)
               	movzwq	-0x106(%rbp), %rdx
               	movzwq	-0xf6(%rbp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x46(%rbp)
               	movzwq	-0x104(%rbp), %rdx
               	movzwq	-0xf4(%rbp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x44(%rbp)
               	movzwq	-0x102(%rbp), %rdx
               	movzwq	-0xf2(%rbp), %rsi
               	cmpl	%esi, %edx
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x42(%rbp)
               	leaq	-0x40(%rbp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movzwq	-0x100(%rbp,%rax,2), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movzwq	-0x110(%rbp,%rax,2), %r8
               	cmpl	%edx, %r8d
               	cmovlq	%rdi, %rsi
               	movw	%si, -0x10(%rbp,%rax,2)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	-0x40(%rbp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rcx
               	movswq	-0xf0(%rbp), %rax
               	movswq	-0xe0(%rbp), %rdx
               	cmpl	%edx, %eax
               	setne	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	negq	%rdx
               	movw	%dx, -0x50(%rbp)
               	movswq	-0xee(%rbp), %rdx
               	movswq	-0xde(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x4e(%rbp)
               	movswq	-0xec(%rbp), %rdx
               	movswq	-0xdc(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x4c(%rbp)
               	movswq	-0xea(%rbp), %rdx
               	movswq	-0xda(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x4a(%rbp)
               	movswq	-0xe8(%rbp), %rdx
               	movswq	-0xd8(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x48(%rbp)
               	movswq	-0xe6(%rbp), %rdx
               	movswq	-0xd6(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x46(%rbp)
               	movswq	-0xe4(%rbp), %rdx
               	movswq	-0xd4(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x44(%rbp)
               	movswq	-0xe2(%rbp), %rdx
               	movswq	-0xd2(%rbp), %rsi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x42(%rbp)
               	leaq	-0x40(%rbp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movswq	-0xe0(%rbp,%rax,2), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movswq	-0xf0(%rbp,%rax,2), %r8
               	cmpl	%edx, %r8d
               	cmoveq	%rdi, %rsi
               	movw	%si, -0x10(%rbp,%rax,2)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	-0x40(%rbp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rcx
               	movswq	-0xf0(%rbp), %rax
               	movswq	-0xe0(%rbp), %rdx
               	cmpl	%edx, %eax
               	setle	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	negq	%rdx
               	movw	%dx, -0x50(%rbp)
               	movswq	-0xee(%rbp), %rdx
               	movswq	-0xde(%rbp), %rsi
               	cmpl	%esi, %edx
               	setle	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x4e(%rbp)
               	movswq	-0xec(%rbp), %rdx
               	movswq	-0xdc(%rbp), %rsi
               	cmpl	%esi, %edx
               	setle	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x4c(%rbp)
               	movswq	-0xea(%rbp), %rdx
               	movswq	-0xda(%rbp), %rsi
               	cmpl	%esi, %edx
               	setle	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x4a(%rbp)
               	movswq	-0xe8(%rbp), %rdx
               	movswq	-0xd8(%rbp), %rsi
               	cmpl	%esi, %edx
               	setle	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x48(%rbp)
               	movswq	-0xe6(%rbp), %rdx
               	movswq	-0xd6(%rbp), %rsi
               	cmpl	%esi, %edx
               	setle	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x46(%rbp)
               	movswq	-0xe4(%rbp), %rdx
               	movswq	-0xd4(%rbp), %rsi
               	cmpl	%esi, %edx
               	setle	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x44(%rbp)
               	movswq	-0xe2(%rbp), %rdx
               	movswq	-0xd2(%rbp), %rsi
               	cmpl	%esi, %edx
               	setle	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movw	%dx, -0x42(%rbp)
               	leaq	-0x40(%rbp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movswq	-0xe0(%rbp,%rax,2), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movswq	-0xf0(%rbp,%rax,2), %r8
               	cmpl	%edx, %r8d
               	cmovgq	%rdi, %rsi
               	movw	%si, -0x10(%rbp,%rax,2)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	-0x40(%rbp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	-0xf0(%rbp), %xmm0
               	movups	-0xe0(%rbp), %xmm1
               	vpcmpgtw	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, -0x50(%rbp)
               	xorl	%eax, %eax
               	movswq	-0xe0(%rbp,%rax,2), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movswq	-0xf0(%rbp,%rax,2), %r8
               	cmpl	%edx, %r8d
               	cmovleq	%rdi, %rsi
               	movw	%si, -0x10(%rbp,%rax,2)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	-0x50(%rbp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	-0xd0(%rbp), %eax
               	movl	-0xc0(%rbp), %ecx
               	cmpl	%ecx, %eax
               	setb	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	negq	%rcx
               	movl	-0xcc(%rbp), %edx
               	movl	-0xbc(%rbp), %esi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	-0xc8(%rbp), %esi
               	movl	-0xb8(%rbp), %edi
               	cmpl	%edi, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movl	-0xc4(%rbp), %edi
               	movl	-0xb4(%rbp), %r8d
               	cmpl	%r8d, %edi
               	setb	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movl	%ecx, -0x50(%rbp)
               	movl	%edx, -0x4c(%rbp)
               	movl	%esi, -0x48(%rbp)
               	movl	%edi, -0x44(%rbp)
               	movl	-0xc0(%rbp,%rax,4), %edx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movl	-0xd0(%rbp,%rax,4), %r8d
               	cmpl	%edx, %r8d
               	cmovaeq	%rdi, %rsi
               	movl	%esi, -0x10(%rbp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	-0x50(%rbp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	-0xd0(%rbp), %xmm0
               	movups	-0xc0(%rbp), %xmm1
               	vpcmpeqd	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, -0x50(%rbp)
               	xorl	%eax, %eax
               	movl	-0xc0(%rbp,%rax,4), %edx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movl	-0xd0(%rbp,%rax,4), %r8d
               	cmpl	%edx, %r8d
               	cmovneq	%rdi, %rsi
               	movl	%esi, -0x10(%rbp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	-0x50(%rbp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	-0xa0(%rbp), %xmm0
               	movups	-0xb0(%rbp), %xmm1
               	vpcmpgtd	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, -0x50(%rbp)
               	xorl	%eax, %eax
               	movl	-0xa0(%rbp,%rax,4), %edx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movl	-0xb0(%rbp,%rax,4), %r8d
               	cmpl	%edx, %r8d
               	cmovgeq	%rdi, %rsi
               	movl	%esi, -0x10(%rbp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	-0x50(%rbp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	-0xb0(%rbp), %eax
               	movl	-0xa0(%rbp), %ecx
               	cmpl	%ecx, %eax
               	setge	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	negq	%rcx
               	movl	-0xac(%rbp), %edx
               	movl	-0x9c(%rbp), %esi
               	cmpl	%esi, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	-0xa8(%rbp), %esi
               	movl	-0x98(%rbp), %edi
               	cmpl	%edi, %esi
               	setge	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movl	-0xa4(%rbp), %edi
               	movl	-0x94(%rbp), %r8d
               	cmpl	%r8d, %edi
               	setge	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movl	%ecx, -0x50(%rbp)
               	movl	%edx, -0x4c(%rbp)
               	movl	%esi, -0x48(%rbp)
               	movl	%edi, -0x44(%rbp)
               	movl	-0xa0(%rbp,%rax,4), %edx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movl	-0xb0(%rbp,%rax,4), %r8d
               	cmpl	%edx, %r8d
               	cmovlq	%rdi, %rsi
               	movl	%esi, -0x10(%rbp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	-0x50(%rbp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	-0xb0(%rbp), %eax
               	movl	-0xa0(%rbp), %ecx
               	cmpl	%ecx, %eax
               	setne	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	negq	%rcx
               	movl	-0xac(%rbp), %edx
               	movl	-0x9c(%rbp), %esi
               	cmpl	%esi, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	-0xa8(%rbp), %esi
               	movl	-0x98(%rbp), %edi
               	cmpl	%edi, %esi
               	setne	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movl	-0xa4(%rbp), %edi
               	movl	-0x94(%rbp), %r8d
               	cmpl	%r8d, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movl	%ecx, -0x50(%rbp)
               	movl	%edx, -0x4c(%rbp)
               	movl	%esi, -0x48(%rbp)
               	movl	%edi, -0x44(%rbp)
               	movl	-0xa0(%rbp,%rax,4), %edx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movl	-0xb0(%rbp,%rax,4), %r8d
               	cmpl	%edx, %r8d
               	cmoveq	%rdi, %rsi
               	movl	%esi, -0x10(%rbp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	-0x50(%rbp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	-0x90(%rbp), %rax
               	movq	-0x80(%rbp), %rdx
               	cmpq	%rdx, %rax
               	setb	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	negq	%rdx
               	movq	-0x88(%rbp), %rsi
               	movq	-0x78(%rbp), %rdi
               	cmpq	%rdi, %rsi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movq	%rdx, -0x50(%rbp)
               	movq	%rsi, -0x48(%rbp)
               	movq	-0x80(%rbp,%rax,8), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movq	-0x90(%rbp,%rax,8), %r8
               	cmpq	%rdx, %r8
               	cmovaeq	%rdi, %rsi
               	movq	%rsi, -0x10(%rbp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	-0x50(%rbp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	-0x90(%rbp), %rax
               	movq	-0x80(%rbp), %rdx
               	cmpq	%rdx, %rax
               	seta	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	negq	%rdx
               	movq	-0x88(%rbp), %rsi
               	movq	-0x78(%rbp), %rdi
               	cmpq	%rdi, %rsi
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movq	%rdx, -0x50(%rbp)
               	movq	%rsi, -0x48(%rbp)
               	movq	-0x80(%rbp,%rax,8), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movq	-0x90(%rbp,%rax,8), %r8
               	cmpq	%rdx, %r8
               	cmovbeq	%rdi, %rsi
               	movq	%rsi, -0x10(%rbp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	-0x50(%rbp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	-0x60(%rbp), %xmm0
               	movups	-0x70(%rbp), %xmm1
               	vpcmpgtq	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, -0x50(%rbp)
               	xorl	%eax, %eax
               	movq	-0x60(%rbp,%rax,8), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movq	-0x70(%rbp,%rax,8), %r8
               	cmpq	%rdx, %r8
               	cmovgeq	%rdi, %rsi
               	movq	%rsi, -0x10(%rbp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	-0x50(%rbp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	-0x70(%rbp), %xmm0
               	movups	-0x60(%rbp), %xmm1
               	vpcmpeqq	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, -0x50(%rbp)
               	xorl	%eax, %eax
               	movq	-0x60(%rbp,%rax,8), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movq	-0x70(%rbp,%rax,8), %r8
               	cmpq	%rdx, %r8
               	cmovneq	%rdi, %rsi
               	movq	%rsi, -0x10(%rbp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	-0x50(%rbp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x8(%rbp), %rcx
               	movzbq	-0x28(%rbp), %rax
               	movzbq	-0x20(%rbp), %rdx
               	cmpl	%edx, %eax
               	setb	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	negq	%rdx
               	movb	%dl, -0x8(%rbp)
               	movzbq	-0x27(%rbp), %rdx
               	movzbq	-0x1f(%rbp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x7(%rbp)
               	movzbq	-0x26(%rbp), %rdx
               	movzbq	-0x1e(%rbp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x6(%rbp)
               	movzbq	-0x25(%rbp), %rdx
               	movzbq	-0x1d(%rbp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x5(%rbp)
               	movzbq	-0x24(%rbp), %rdx
               	movzbq	-0x1c(%rbp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x4(%rbp)
               	movzbq	-0x23(%rbp), %rdx
               	movzbq	-0x1b(%rbp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x3(%rbp)
               	movzbq	-0x22(%rbp), %rdx
               	movzbq	-0x1a(%rbp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x2(%rbp)
               	movzbq	-0x21(%rbp), %rdx
               	movzbq	-0x19(%rbp), %rsi
               	cmpl	%esi, %edx
               	setb	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x1(%rbp)
               	leaq	-0x18(%rbp), %rdx
               	movq	(%rcx), %r10
               	movq	%r10, (%rdx)
               	movzbq	-0x20(%rbp,%rax), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movzbq	-0x28(%rbp,%rax), %r8
               	cmpl	%edx, %r8d
               	cmovgeq	%rdi, %rsi
               	movb	%sil, -0x8(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	-0x18(%rbp,%rax), %rsi
               	movzbq	-0x8(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	-0x8(%rbp), %rax
               	leaq	<rip>, %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	leaq	-0x60(%rbp), %rcx
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x40(%rbp), %rdx
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movss	-0x8(%rbp), %xmm0
               	movss	%xmm0, -0x58(%rbp)
               	movss	-0x60(%rbp), %xmm0
               	movss	-0x40(%rbp), %xmm1
               	ucomiss	%xmm1, %xmm0
               	sete	%sil
               	movzbq	%sil, %rsi
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rsi
               	xorl	%eax, %eax
               	negq	%rsi
               	movss	-0x5c(%rbp), %xmm0
               	movss	-0x3c(%rbp), %xmm1
               	ucomiss	%xmm1, %xmm0
               	sete	%dil
               	movzbq	%dil, %rdi
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rdi
               	negq	%rdi
               	movss	-0x58(%rbp), %xmm0
               	movss	-0x38(%rbp), %xmm1
               	ucomiss	%xmm1, %xmm0
               	sete	%r8b
               	movzbq	%r8b, %r8
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %r8
               	negq	%r8
               	movss	-0x54(%rbp), %xmm0
               	movss	-0x34(%rbp), %xmm1
               	ucomiss	%xmm1, %xmm0
               	sete	%r9b
               	movzbq	%r9b, %r9
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %r9
               	negq	%r9
               	movl	%esi, -0x50(%rbp)
               	movl	%edi, -0x4c(%rbp)
               	movl	%r8d, -0x48(%rbp)
               	movl	%r9d, -0x44(%rbp)
               	movss	-0x40(%rbp,%rax,4), %xmm0
               	movq	$-0x1, %rdi
               	xorl	%r8d, %r8d
               	movss	-0x60(%rbp,%rax,4), %xmm1
               	ucomiss	%xmm0, %xmm1
               	cmovneq	%r8, %rdi
               	cmovpq	%r8, %rdi
               	movl	%edi, -0x10(%rbp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	-0x50(%rbp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x60(%rbp), %r8
               	leaq	-0x40(%rbp), %r9
               	movss	-0x60(%rbp), %xmm0
               	movss	-0x40(%rbp), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setne	%cl
               	movzbq	%cl, %rcx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rcx
               	xorl	%eax, %eax
               	negq	%rcx
               	movss	-0x5c(%rbp), %xmm0
               	movss	-0x3c(%rbp), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setne	%dl
               	movzbq	%dl, %rdx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rdx
               	negq	%rdx
               	movss	-0x58(%rbp), %xmm0
               	movss	-0x38(%rbp), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setne	%sil
               	movzbq	%sil, %rsi
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rsi
               	negq	%rsi
               	movss	-0x54(%rbp), %xmm0
               	movss	-0x34(%rbp), %xmm1
               	ucomiss	%xmm1, %xmm0
               	setne	%dil
               	movzbq	%dil, %rdi
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rdi
               	negq	%rdi
               	movl	%ecx, -0x50(%rbp)
               	movl	%edx, -0x4c(%rbp)
               	movl	%esi, -0x48(%rbp)
               	movl	%edi, -0x44(%rbp)
               	movss	-0x40(%rbp,%rax,4), %xmm0
               	movq	$-0x1, %rdx
               	xorl	%esi, %esi
               	movss	-0x60(%rbp,%rax,4), %xmm1
               	ucomiss	%xmm0, %xmm1
               	movq	%rsi, %r10
               	cmovpq	%rdx, %r10
               	cmoveq	%r10, %rdx
               	movl	%edx, -0x10(%rbp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	-0x50(%rbp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x60(%rbp), %r8
               	leaq	-0x40(%rbp), %r9
               	movss	-0x60(%rbp), %xmm0
               	movss	-0x40(%rbp), %xmm1
               	comiss	%xmm0, %xmm1
               	seta	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	negq	%rcx
               	movss	-0x5c(%rbp), %xmm0
               	movss	-0x3c(%rbp), %xmm1
               	comiss	%xmm0, %xmm1
               	seta	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movss	-0x58(%rbp), %xmm0
               	movss	-0x38(%rbp), %xmm1
               	comiss	%xmm0, %xmm1
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movss	-0x54(%rbp), %xmm0
               	movss	-0x34(%rbp), %xmm1
               	comiss	%xmm0, %xmm1
               	seta	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movl	%ecx, -0x50(%rbp)
               	movl	%edx, -0x4c(%rbp)
               	movl	%esi, -0x48(%rbp)
               	movl	%edi, -0x44(%rbp)
               	movss	-0x40(%rbp,%rax,4), %xmm0
               	movq	$-0x1, %rdx
               	xorl	%esi, %esi
               	movss	-0x60(%rbp,%rax,4), %xmm1
               	comiss	%xmm1, %xmm0
               	cmovbeq	%rsi, %rdx
               	movl	%edx, -0x10(%rbp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	-0x50(%rbp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x60(%rbp), %r8
               	leaq	-0x40(%rbp), %r9
               	movss	-0x60(%rbp), %xmm0
               	movss	-0x40(%rbp), %xmm1
               	comiss	%xmm0, %xmm1
               	setae	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	negq	%rcx
               	movss	-0x5c(%rbp), %xmm0
               	movss	-0x3c(%rbp), %xmm1
               	comiss	%xmm0, %xmm1
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movss	-0x58(%rbp), %xmm0
               	movss	-0x38(%rbp), %xmm1
               	comiss	%xmm0, %xmm1
               	setae	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movss	-0x54(%rbp), %xmm0
               	movss	-0x34(%rbp), %xmm1
               	comiss	%xmm0, %xmm1
               	setae	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movl	%ecx, -0x50(%rbp)
               	movl	%edx, -0x4c(%rbp)
               	movl	%esi, -0x48(%rbp)
               	movl	%edi, -0x44(%rbp)
               	movss	-0x40(%rbp,%rax,4), %xmm0
               	movq	$-0x1, %rdx
               	xorl	%esi, %esi
               	movss	-0x60(%rbp,%rax,4), %xmm1
               	comiss	%xmm1, %xmm0
               	cmovbq	%rsi, %rdx
               	movl	%edx, -0x10(%rbp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	-0x50(%rbp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x60(%rbp), %r8
               	leaq	-0x40(%rbp), %r9
               	movss	-0x60(%rbp), %xmm0
               	movss	-0x40(%rbp), %xmm1
               	comiss	%xmm1, %xmm0
               	seta	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	negq	%rcx
               	movss	-0x5c(%rbp), %xmm0
               	movss	-0x3c(%rbp), %xmm1
               	comiss	%xmm1, %xmm0
               	seta	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movss	-0x58(%rbp), %xmm0
               	movss	-0x38(%rbp), %xmm1
               	comiss	%xmm1, %xmm0
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movss	-0x54(%rbp), %xmm0
               	movss	-0x34(%rbp), %xmm1
               	comiss	%xmm1, %xmm0
               	seta	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movl	%ecx, -0x50(%rbp)
               	movl	%edx, -0x4c(%rbp)
               	movl	%esi, -0x48(%rbp)
               	movl	%edi, -0x44(%rbp)
               	movss	-0x40(%rbp,%rax,4), %xmm0
               	movq	$-0x1, %rdx
               	xorl	%esi, %esi
               	movss	-0x60(%rbp,%rax,4), %xmm1
               	comiss	%xmm0, %xmm1
               	cmovbeq	%rsi, %rdx
               	movl	%edx, -0x10(%rbp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	-0x50(%rbp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x60(%rbp), %r8
               	leaq	-0x40(%rbp), %r9
               	movss	-0x60(%rbp), %xmm0
               	movss	-0x40(%rbp), %xmm1
               	comiss	%xmm1, %xmm0
               	setae	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	negq	%rcx
               	movss	-0x5c(%rbp), %xmm0
               	movss	-0x3c(%rbp), %xmm1
               	comiss	%xmm1, %xmm0
               	setae	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movss	-0x58(%rbp), %xmm0
               	movss	-0x38(%rbp), %xmm1
               	comiss	%xmm1, %xmm0
               	setae	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movss	-0x54(%rbp), %xmm0
               	movss	-0x34(%rbp), %xmm1
               	comiss	%xmm1, %xmm0
               	setae	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movl	%ecx, -0x50(%rbp)
               	movl	%edx, -0x4c(%rbp)
               	movl	%esi, -0x48(%rbp)
               	movl	%edi, -0x44(%rbp)
               	movss	-0x40(%rbp,%rax,4), %xmm0
               	movq	$-0x1, %rdx
               	xorl	%esi, %esi
               	movss	-0x60(%rbp,%rax,4), %xmm1
               	comiss	%xmm0, %xmm1
               	cmovbq	%rsi, %rdx
               	movl	%edx, -0x10(%rbp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	-0x50(%rbp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x60(%rbp), %r8
               	movss	<rip>, %xmm0
               	movss	-0x60(%rbp), %xmm1
               	comiss	%xmm0, %xmm1
               	seta	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	negq	%rdx
               	movss	-0x5c(%rbp), %xmm1
               	comiss	%xmm0, %xmm1
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movss	-0x58(%rbp), %xmm1
               	comiss	%xmm0, %xmm1
               	seta	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movss	-0x54(%rbp), %xmm1
               	comiss	%xmm0, %xmm1
               	seta	%r9b
               	movzbq	%r9b, %r9
               	negq	%r9
               	movl	%edx, -0x50(%rbp)
               	movl	%esi, -0x4c(%rbp)
               	movl	%edi, -0x48(%rbp)
               	movl	%r9d, -0x44(%rbp)
               	movss	<rip>, %xmm0
               	movq	$-0x1, %rdx
               	xorl	%esi, %esi
               	movss	-0x60(%rbp,%rax,4), %xmm1
               	comiss	%xmm0, %xmm1
               	cmovbeq	%rsi, %rdx
               	movl	%edx, -0x10(%rbp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	-0x50(%rbp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x8(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x60(%rbp), %rcx
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x40(%rbp), %rdx
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movsd	-0x8(%rbp), %xmm0
               	movsd	%xmm0, -0x58(%rbp)
               	movsd	-0x60(%rbp), %xmm1
               	movsd	-0x40(%rbp), %xmm2
               	ucomisd	%xmm2, %xmm1
               	sete	%sil
               	movzbq	%sil, %rsi
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rsi
               	xorl	%eax, %eax
               	negq	%rsi
               	movsd	-0x38(%rbp), %xmm1
               	ucomisd	%xmm1, %xmm0
               	sete	%dil
               	movzbq	%dil, %rdi
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rdi
               	negq	%rdi
               	movq	%rsi, -0x50(%rbp)
               	movq	%rdi, -0x48(%rbp)
               	vmovq	-0x40(%rbp,%rax,8), %xmm0
               	movq	$-0x1, %rdi
               	xorl	%r8d, %r8d
               	vmovq	-0x60(%rbp,%rax,8), %xmm1
               	ucomisd	%xmm0, %xmm1
               	cmovneq	%r8, %rdi
               	cmovpq	%r8, %rdi
               	movq	%rdi, -0x10(%rbp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	-0x50(%rbp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movsd	-0x60(%rbp), %xmm0
               	movsd	-0x40(%rbp), %xmm1
               	ucomisd	%xmm1, %xmm0
               	setne	%dl
               	movzbq	%dl, %rdx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rdx
               	xorl	%eax, %eax
               	negq	%rdx
               	movsd	-0x58(%rbp), %xmm0
               	movsd	-0x38(%rbp), %xmm1
               	ucomisd	%xmm1, %xmm0
               	setne	%sil
               	movzbq	%sil, %rsi
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rsi
               	negq	%rsi
               	movq	%rdx, -0x50(%rbp)
               	movq	%rsi, -0x48(%rbp)
               	vmovq	-0x40(%rbp,%rax,8), %xmm0
               	movq	$-0x1, %rdx
               	xorl	%esi, %esi
               	vmovq	-0x60(%rbp,%rax,8), %xmm1
               	ucomisd	%xmm0, %xmm1
               	movq	%rsi, %r10
               	cmovpq	%rdx, %r10
               	cmoveq	%r10, %rdx
               	movq	%rdx, -0x10(%rbp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	-0x50(%rbp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movsd	-0x60(%rbp), %xmm0
               	movsd	-0x40(%rbp), %xmm1
               	comisd	%xmm0, %xmm1
               	seta	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	negq	%rdx
               	movsd	-0x58(%rbp), %xmm0
               	movsd	-0x38(%rbp), %xmm1
               	comisd	%xmm0, %xmm1
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movq	%rdx, -0x50(%rbp)
               	movq	%rsi, -0x48(%rbp)
               	vmovq	-0x40(%rbp,%rax,8), %xmm0
               	movq	$-0x1, %rdx
               	xorl	%esi, %esi
               	vmovq	-0x60(%rbp,%rax,8), %xmm1
               	comisd	%xmm1, %xmm0
               	cmovbeq	%rsi, %rdx
               	movq	%rdx, -0x10(%rbp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	-0x50(%rbp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rdx
               	movzbq	-0x150(%rbp), %rax
               	cmpl	$0x64, %eax
               	seta	%sil
               	movzbq	%sil, %rsi
               	xorl	%eax, %eax
               	negq	%rsi
               	movb	%sil, -0x50(%rbp)
               	movzbq	-0x14f(%rbp), %rsi
               	cmpl	$0x64, %esi
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, -0x4f(%rbp)
               	movzbq	-0x14e(%rbp), %rsi
               	cmpl	$0x64, %esi
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, -0x4e(%rbp)
               	movzbq	-0x14d(%rbp), %rsi
               	cmpl	$0x64, %esi
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, -0x4d(%rbp)
               	movzbq	-0x14c(%rbp), %rsi
               	cmpl	$0x64, %esi
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, -0x4c(%rbp)
               	movzbq	-0x14b(%rbp), %rsi
               	cmpl	$0x64, %esi
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, -0x4b(%rbp)
               	movzbq	-0x14a(%rbp), %rsi
               	cmpl	$0x64, %esi
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, -0x4a(%rbp)
               	movzbq	-0x149(%rbp), %rsi
               	cmpl	$0x64, %esi
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, -0x49(%rbp)
               	movzbq	-0x148(%rbp), %rsi
               	cmpl	$0x64, %esi
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, -0x48(%rbp)
               	movzbq	-0x147(%rbp), %rsi
               	cmpl	$0x64, %esi
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, -0x47(%rbp)
               	movzbq	-0x146(%rbp), %rsi
               	cmpl	$0x64, %esi
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, -0x46(%rbp)
               	movzbq	-0x145(%rbp), %rsi
               	cmpl	$0x64, %esi
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, -0x45(%rbp)
               	movzbq	-0x144(%rbp), %rsi
               	cmpl	$0x64, %esi
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, -0x44(%rbp)
               	movzbq	-0x143(%rbp), %rsi
               	cmpl	$0x64, %esi
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, -0x43(%rbp)
               	movzbq	-0x142(%rbp), %rsi
               	cmpl	$0x64, %esi
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, -0x42(%rbp)
               	movzbq	-0x141(%rbp), %rsi
               	cmpl	$0x64, %esi
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, -0x41(%rbp)
               	leaq	-0x40(%rbp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movq	$-0x1, %rdx
               	xorl	%esi, %esi
               	movzbq	-0x150(%rbp,%rax), %rdi
               	cmpl	$0x64, %edi
               	cmovleq	%rsi, %rdx
               	movb	%dl, -0x10(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	-0x40(%rbp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rdx
               	movzbq	-0x150(%rbp), %rax
               	cmpl	$0x3, %eax
               	sete	%sil
               	movzbq	%sil, %rsi
               	xorl	%eax, %eax
               	negq	%rsi
               	movb	%sil, -0x50(%rbp)
               	movzbq	-0x14f(%rbp), %rsi
               	cmpl	$0x3, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, -0x4f(%rbp)
               	movzbq	-0x14e(%rbp), %rsi
               	cmpl	$0x3, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, -0x4e(%rbp)
               	movzbq	-0x14d(%rbp), %rsi
               	cmpl	$0x3, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, -0x4d(%rbp)
               	movzbq	-0x14c(%rbp), %rsi
               	cmpl	$0x3, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, -0x4c(%rbp)
               	movzbq	-0x14b(%rbp), %rsi
               	cmpl	$0x3, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, -0x4b(%rbp)
               	movzbq	-0x14a(%rbp), %rsi
               	cmpl	$0x3, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, -0x4a(%rbp)
               	movzbq	-0x149(%rbp), %rsi
               	cmpl	$0x3, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, -0x49(%rbp)
               	movzbq	-0x148(%rbp), %rsi
               	cmpl	$0x3, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, -0x48(%rbp)
               	movzbq	-0x147(%rbp), %rsi
               	cmpl	$0x3, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, -0x47(%rbp)
               	movzbq	-0x146(%rbp), %rsi
               	cmpl	$0x3, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, -0x46(%rbp)
               	movzbq	-0x145(%rbp), %rsi
               	cmpl	$0x3, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, -0x45(%rbp)
               	movzbq	-0x144(%rbp), %rsi
               	cmpl	$0x3, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, -0x44(%rbp)
               	movzbq	-0x143(%rbp), %rsi
               	cmpl	$0x3, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, -0x43(%rbp)
               	movzbq	-0x142(%rbp), %rsi
               	cmpl	$0x3, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, -0x42(%rbp)
               	movzbq	-0x141(%rbp), %rsi
               	cmpl	$0x3, %esi
               	sete	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, -0x41(%rbp)
               	leaq	-0x40(%rbp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movq	$-0x1, %rdx
               	xorl	%esi, %esi
               	movzbq	-0x150(%rbp,%rax), %rdi
               	cmpl	$0x3, %edi
               	cmovneq	%rsi, %rdx
               	movb	%dl, -0x10(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	-0x40(%rbp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rdx
               	movzbq	-0x150(%rbp), %rax
               	cmpl	$0xff, %eax
               	setb	%sil
               	movzbq	%sil, %rsi
               	xorl	%eax, %eax
               	negq	%rsi
               	movb	%sil, -0x50(%rbp)
               	movzbq	-0x14f(%rbp), %rsi
               	cmpl	$0xff, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, -0x4f(%rbp)
               	movzbq	-0x14e(%rbp), %rsi
               	cmpl	$0xff, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, -0x4e(%rbp)
               	movzbq	-0x14d(%rbp), %rsi
               	cmpl	$0xff, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, -0x4d(%rbp)
               	movzbq	-0x14c(%rbp), %rsi
               	cmpl	$0xff, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, -0x4c(%rbp)
               	movzbq	-0x14b(%rbp), %rsi
               	cmpl	$0xff, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, -0x4b(%rbp)
               	movzbq	-0x14a(%rbp), %rsi
               	cmpl	$0xff, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, -0x4a(%rbp)
               	movzbq	-0x149(%rbp), %rsi
               	cmpl	$0xff, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, -0x49(%rbp)
               	movzbq	-0x148(%rbp), %rsi
               	cmpl	$0xff, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, -0x48(%rbp)
               	movzbq	-0x147(%rbp), %rsi
               	cmpl	$0xff, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, -0x47(%rbp)
               	movzbq	-0x146(%rbp), %rsi
               	cmpl	$0xff, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, -0x46(%rbp)
               	movzbq	-0x145(%rbp), %rsi
               	cmpl	$0xff, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, -0x45(%rbp)
               	movzbq	-0x144(%rbp), %rsi
               	cmpl	$0xff, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, -0x44(%rbp)
               	movzbq	-0x143(%rbp), %rsi
               	cmpl	$0xff, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, -0x43(%rbp)
               	movzbq	-0x142(%rbp), %rsi
               	cmpl	$0xff, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, -0x42(%rbp)
               	movzbq	-0x141(%rbp), %rsi
               	cmpl	$0xff, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, -0x41(%rbp)
               	leaq	-0x40(%rbp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movq	$-0x1, %rdx
               	xorl	%esi, %esi
               	movzbq	-0x150(%rbp,%rax), %rdi
               	cmpl	$0xff, %edi
               	cmovgeq	%rsi, %rdx
               	movb	%dl, -0x10(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	-0x40(%rbp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	$-0x5, %rax
               	leaq	-0x50(%rbp), %rsi
               	movsbq	-0x130(%rbp), %rcx
               	cmpl	%eax, %ecx
               	setg	%dil
               	movzbq	%dil, %rdi
               	xorl	%ecx, %ecx
               	negq	%rdi
               	movb	%dil, -0x50(%rbp)
               	movsbq	-0x12f(%rbp), %rdi
               	cmpl	%eax, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x4f(%rbp)
               	movsbq	-0x12e(%rbp), %rdi
               	cmpl	%eax, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x4e(%rbp)
               	movsbq	-0x12d(%rbp), %rdi
               	cmpl	%eax, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x4d(%rbp)
               	movsbq	-0x12c(%rbp), %rdi
               	cmpl	%eax, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x4c(%rbp)
               	movsbq	-0x12b(%rbp), %rdi
               	cmpl	%eax, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x4b(%rbp)
               	movsbq	-0x12a(%rbp), %rdi
               	cmpl	%eax, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x4a(%rbp)
               	movsbq	-0x129(%rbp), %rdi
               	cmpl	%eax, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x49(%rbp)
               	movsbq	-0x128(%rbp), %rdi
               	cmpl	%eax, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x48(%rbp)
               	movsbq	-0x127(%rbp), %rdi
               	cmpl	%eax, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x47(%rbp)
               	movsbq	-0x126(%rbp), %rdi
               	cmpl	%eax, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x46(%rbp)
               	movsbq	-0x125(%rbp), %rdi
               	cmpl	%eax, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x45(%rbp)
               	movsbq	-0x124(%rbp), %rdi
               	cmpl	%eax, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x44(%rbp)
               	movsbq	-0x123(%rbp), %rdi
               	cmpl	%eax, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x43(%rbp)
               	movsbq	-0x122(%rbp), %rdi
               	cmpl	%eax, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x42(%rbp)
               	movsbq	-0x121(%rbp), %rdi
               	cmpl	%eax, %edi
               	setg	%al
               	movzbq	%al, %rax
               	negq	%rax
               	movb	%al, -0x41(%rbp)
               	leaq	-0x40(%rbp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	movq	$-0x1, %rax
               	xorl	%esi, %esi
               	movsbq	-0x130(%rbp,%rcx), %rdi
               	cmpl	$-0x5, %edi
               	cmovleq	%rsi, %rax
               	movb	%al, -0x10(%rbp,%rcx)
               	incq	%rcx
               	cmpl	$0x10, %ecx
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	-0x40(%rbp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movl	-0xb0(%rbp), %edx
               	testl	%edx, %edx
               	setl	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	-0xac(%rbp), %esi
               	testl	%esi, %esi
               	setl	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movl	-0xa8(%rbp), %edi
               	testl	%edi, %edi
               	setl	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movl	-0xa4(%rbp), %r9d
               	testl	%r9d, %r9d
               	setl	%r9b
               	movzbq	%r9b, %r9
               	negq	%r9
               	movl	%edx, -0x50(%rbp)
               	movl	%esi, -0x4c(%rbp)
               	movl	%edi, -0x48(%rbp)
               	movl	%r9d, -0x44(%rbp)
               	movq	$-0x1, %rdx
               	xorl	%esi, %esi
               	movl	-0xb0(%rbp,%rax,4), %edi
               	testl	%edi, %edi
               	cmovgeq	%rsi, %rdx
               	movl	%edx, -0x10(%rbp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	-0x50(%rbp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	-0x90(%rbp), %rax
               	cmpq	$0x5, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	negq	%rdx
               	movq	-0x88(%rbp), %rsi
               	cmpq	$0x5, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movq	%rdx, -0x50(%rbp)
               	movq	%rsi, -0x48(%rbp)
               	movq	$-0x1, %rdx
               	xorl	%esi, %esi
               	movq	-0x90(%rbp,%rax,8), %rdi
               	cmpq	$0x5, %rdi
               	cmoveq	%rsi, %rdx
               	movq	%rdx, -0x10(%rbp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	-0x50(%rbp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rdx
               	movzbq	-0x150(%rbp), %rax
               	cmpl	$0x64, %eax
               	setb	%sil
               	movzbq	%sil, %rsi
               	xorl	%eax, %eax
               	negq	%rsi
               	movb	%sil, -0x50(%rbp)
               	movzbq	-0x14f(%rbp), %rsi
               	cmpl	$0x64, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, -0x4f(%rbp)
               	movzbq	-0x14e(%rbp), %rsi
               	cmpl	$0x64, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, -0x4e(%rbp)
               	movzbq	-0x14d(%rbp), %rsi
               	cmpl	$0x64, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, -0x4d(%rbp)
               	movzbq	-0x14c(%rbp), %rsi
               	cmpl	$0x64, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, -0x4c(%rbp)
               	movzbq	-0x14b(%rbp), %rsi
               	cmpl	$0x64, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, -0x4b(%rbp)
               	movzbq	-0x14a(%rbp), %rsi
               	cmpl	$0x64, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, -0x4a(%rbp)
               	movzbq	-0x149(%rbp), %rsi
               	cmpl	$0x64, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, -0x49(%rbp)
               	movzbq	-0x148(%rbp), %rsi
               	cmpl	$0x64, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, -0x48(%rbp)
               	movzbq	-0x147(%rbp), %rsi
               	cmpl	$0x64, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, -0x47(%rbp)
               	movzbq	-0x146(%rbp), %rsi
               	cmpl	$0x64, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, -0x46(%rbp)
               	movzbq	-0x145(%rbp), %rsi
               	cmpl	$0x64, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, -0x45(%rbp)
               	movzbq	-0x144(%rbp), %rsi
               	cmpl	$0x64, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, -0x44(%rbp)
               	movzbq	-0x143(%rbp), %rsi
               	cmpl	$0x64, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, -0x43(%rbp)
               	movzbq	-0x142(%rbp), %rsi
               	cmpl	$0x64, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, -0x42(%rbp)
               	movzbq	-0x141(%rbp), %rsi
               	cmpl	$0x64, %esi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movb	%sil, -0x41(%rbp)
               	leaq	-0x40(%rbp), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	movq	$-0x1, %rdx
               	xorl	%esi, %esi
               	movzbq	-0x150(%rbp,%rax), %rdi
               	cmpl	$0x64, %edi
               	cmovgeq	%rsi, %rdx
               	movb	%dl, -0x10(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	-0x40(%rbp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movl	-0xb0(%rbp), %edx
               	testl	%edx, %edx
               	setge	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	-0xac(%rbp), %esi
               	testl	%esi, %esi
               	setge	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movl	-0xa8(%rbp), %edi
               	testl	%edi, %edi
               	setge	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movl	-0xa4(%rbp), %r9d
               	testl	%r9d, %r9d
               	setge	%r9b
               	movzbq	%r9b, %r9
               	negq	%r9
               	movl	%edx, -0x50(%rbp)
               	movl	%esi, -0x4c(%rbp)
               	movl	%edi, -0x48(%rbp)
               	movl	%r9d, -0x44(%rbp)
               	movq	$-0x1, %rdx
               	xorl	%esi, %esi
               	movl	-0xb0(%rbp,%rax,4), %edi
               	testl	%edi, %edi
               	cmovlq	%rsi, %rdx
               	movl	%edx, -0x10(%rbp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	-0x50(%rbp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
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
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x31, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x30, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2f, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2e, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2d, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2c, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2b, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2a, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x29, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x28, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x27, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x26, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x25, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x24, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x23, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x22, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x21, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x20, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1f, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1e, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1d, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1c, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1b, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1a, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x19, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x18, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x17, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x16, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x15, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x14, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x13, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x12, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x11, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x10, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xf, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xe, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xd, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xc, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xb, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xa, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x9, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x8, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x7, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
