
gcc_vector_compare_ops.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
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
               	subq	$0x150, %rsp            # imm = 0x150
               	pushq	%r12
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
               	movapd	%xmm0, %xmm15
               	pcmpeqb	%xmm0, %xmm15
               	movapd	%xmm15, %xmm0
               	leaq	-0x50(%rbp), %rcx
               	movups	%xmm0, -0x50(%rbp)
               	xorl	%eax, %eax
               	movsbq	(%rcx,%rax), %rdx
               	cmpl	$-0x1, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x150(%rbp), %rdx
               	leaq	-0x140(%rbp), %rsi
               	movups	-0x150(%rbp), %xmm0
               	movups	-0x140(%rbp), %xmm1
               	pcmpeqb	%xmm1, %xmm0
               	movups	%xmm0, -0x50(%rbp)
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	leaq	-0x10(%rbp), %rdi
               	movzbq	(%rsi,%rax), %r8
               	movq	$-0x1, %r9
               	movzbq	(%rdx,%rax), %rbx
               	cmpl	%r8d, %ebx
               	movq	%rcx, %r8
               	cmoveq	%r9, %r8
               	movb	%r8b, (%rdi,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x150(%rbp), %r9
               	leaq	-0x140(%rbp), %rbx
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
               	leaq	-0x10(%rbp), %rcx
               	movzbq	(%rbx,%rax), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movzbq	(%r9,%rax), %r8
               	cmpl	%edx, %r8d
               	movq	%rdi, %rdx
               	cmovneq	%rsi, %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x150(%rbp), %r9
               	leaq	-0x140(%rbp), %rbx
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
               	leaq	-0x10(%rbp), %rcx
               	movzbq	(%rbx,%rax), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movzbq	(%r9,%rax), %r8
               	cmpl	%edx, %r8d
               	movq	%rdi, %rdx
               	cmovlq	%rsi, %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x150(%rbp), %r9
               	leaq	-0x140(%rbp), %rbx
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
               	leaq	-0x10(%rbp), %rcx
               	movzbq	(%rbx,%rax), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movzbq	(%r9,%rax), %r8
               	cmpl	%edx, %r8d
               	movq	%rdi, %rdx
               	cmovleq	%rsi, %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x150(%rbp), %r9
               	leaq	-0x140(%rbp), %rbx
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
               	leaq	-0x10(%rbp), %rcx
               	movzbq	(%rbx,%rax), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movzbq	(%r9,%rax), %r8
               	cmpl	%edx, %r8d
               	movq	%rdi, %rdx
               	cmovgq	%rsi, %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x150(%rbp), %r9
               	leaq	-0x140(%rbp), %rbx
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
               	leaq	-0x10(%rbp), %rcx
               	movzbq	(%rbx,%rax), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movzbq	(%r9,%rax), %r8
               	cmpl	%edx, %r8d
               	movq	%rdi, %rdx
               	cmovgeq	%rsi, %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rdx
               	leaq	-0x10(%rbp), %rcx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x130(%rbp), %r9
               	leaq	-0x120(%rbp), %rbx
               	movups	-0x130(%rbp), %xmm0
               	movups	-0x120(%rbp), %xmm1
               	pcmpeqb	%xmm1, %xmm0
               	movups	%xmm0, -0x50(%rbp)
               	xorl	%eax, %eax
               	movsbq	(%rbx,%rax), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movsbq	(%r9,%rax), %r8
               	cmpl	%edx, %r8d
               	movq	%rdi, %rdx
               	cmoveq	%rsi, %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x130(%rbp), %r9
               	leaq	-0x120(%rbp), %rbx
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
               	leaq	-0x10(%rbp), %rcx
               	movsbq	(%rbx,%rax), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movsbq	(%r9,%rax), %r8
               	cmpl	%edx, %r8d
               	movq	%rdi, %rdx
               	cmovneq	%rsi, %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rdx
               	leaq	-0x10(%rbp), %rcx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x130(%rbp), %r9
               	leaq	-0x120(%rbp), %rbx
               	movups	-0x120(%rbp), %xmm0
               	movups	-0x130(%rbp), %xmm1
               	pcmpgtb	%xmm1, %xmm0
               	movups	%xmm0, -0x50(%rbp)
               	xorl	%eax, %eax
               	movsbq	(%rbx,%rax), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movsbq	(%r9,%rax), %r8
               	cmpl	%edx, %r8d
               	movq	%rdi, %rdx
               	cmovlq	%rsi, %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x130(%rbp), %r9
               	leaq	-0x120(%rbp), %rbx
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
               	leaq	-0x10(%rbp), %rcx
               	movsbq	(%rbx,%rax), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movsbq	(%r9,%rax), %r8
               	cmpl	%edx, %r8d
               	movq	%rdi, %rdx
               	cmovleq	%rsi, %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rdx
               	leaq	-0x10(%rbp), %rcx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x130(%rbp), %r9
               	leaq	-0x120(%rbp), %rbx
               	movups	-0x130(%rbp), %xmm0
               	movups	-0x120(%rbp), %xmm1
               	pcmpgtb	%xmm1, %xmm0
               	movups	%xmm0, -0x50(%rbp)
               	xorl	%eax, %eax
               	movsbq	(%rbx,%rax), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movsbq	(%r9,%rax), %r8
               	cmpl	%edx, %r8d
               	movq	%rdi, %rdx
               	cmovgq	%rsi, %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x130(%rbp), %r9
               	leaq	-0x120(%rbp), %rbx
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
               	leaq	-0x10(%rbp), %rcx
               	movsbq	(%rbx,%rax), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movsbq	(%r9,%rax), %r8
               	cmpl	%edx, %r8d
               	movq	%rdi, %rdx
               	cmovgeq	%rsi, %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x110(%rbp), %rbx
               	leaq	-0x100(%rbp), %r12
               	movups	-0x110(%rbp), %xmm0
               	movups	-0x100(%rbp), %xmm1
               	pcmpeqw	%xmm1, %xmm0
               	movups	%xmm0, -0x50(%rbp)
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	shlq	%rcx
               	leaq	(%rdx,%rcx), %rsi
               	leaq	(%rbx,%rcx), %rdi
               	addq	%r12, %rcx
               	movzwq	(%rcx), %rcx
               	movq	$-0x1, %r8
               	xorl	%r9d, %r9d
               	movzwq	(%rdi), %rdi
               	cmpl	%ecx, %edi
               	movq	%r9, %rcx
               	cmoveq	%r8, %rcx
               	movw	%cx, (%rsi)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x110(%rbp), %r9
               	leaq	-0x100(%rbp), %rbx
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
               	leaq	-0x10(%rbp), %rdx
               	movq	%rax, %rcx
               	shlq	%rcx
               	addq	%rcx, %rdx
               	leaq	(%r9,%rcx), %rsi
               	addq	%rbx, %rcx
               	movzwq	(%rcx), %rcx
               	movq	$-0x1, %rdi
               	xorl	%r8d, %r8d
               	movzwq	(%rsi), %rsi
               	cmpl	%ecx, %esi
               	movq	%r8, %rcx
               	cmovlq	%rdi, %rcx
               	movw	%cx, (%rdx)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x110(%rbp), %r9
               	leaq	-0x100(%rbp), %rbx
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
               	leaq	-0x10(%rbp), %rdx
               	movq	%rax, %rcx
               	shlq	%rcx
               	addq	%rcx, %rdx
               	leaq	(%r9,%rcx), %rsi
               	addq	%rbx, %rcx
               	movzwq	(%rcx), %rcx
               	movq	$-0x1, %rdi
               	xorl	%r8d, %r8d
               	movzwq	(%rsi), %rsi
               	cmpl	%ecx, %esi
               	movq	%r8, %rcx
               	cmovgeq	%rdi, %rcx
               	movw	%cx, (%rdx)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0xf0(%rbp), %r9
               	leaq	-0xe0(%rbp), %rbx
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
               	leaq	-0x10(%rbp), %rdx
               	movq	%rax, %rcx
               	shlq	%rcx
               	addq	%rcx, %rdx
               	leaq	(%r9,%rcx), %rsi
               	addq	%rbx, %rcx
               	movswq	(%rcx), %rcx
               	movq	$-0x1, %rdi
               	xorl	%r8d, %r8d
               	movswq	(%rsi), %rsi
               	cmpl	%ecx, %esi
               	movq	%r8, %rcx
               	cmovneq	%rdi, %rcx
               	movw	%cx, (%rdx)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0xf0(%rbp), %r9
               	leaq	-0xe0(%rbp), %rbx
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
               	leaq	-0x10(%rbp), %rdx
               	movq	%rax, %rcx
               	shlq	%rcx
               	addq	%rcx, %rdx
               	leaq	(%r9,%rcx), %rsi
               	addq	%rbx, %rcx
               	movswq	(%rcx), %rcx
               	movq	$-0x1, %rdi
               	xorl	%r8d, %r8d
               	movswq	(%rsi), %rsi
               	cmpl	%ecx, %esi
               	movq	%r8, %rcx
               	cmovleq	%rdi, %rcx
               	movw	%cx, (%rdx)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0xf0(%rbp), %rbx
               	leaq	-0xe0(%rbp), %r12
               	movups	-0xf0(%rbp), %xmm0
               	movups	-0xe0(%rbp), %xmm1
               	pcmpgtw	%xmm1, %xmm0
               	movups	%xmm0, -0x50(%rbp)
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	shlq	%rcx
               	leaq	(%rdx,%rcx), %rsi
               	leaq	(%rbx,%rcx), %rdi
               	addq	%r12, %rcx
               	movswq	(%rcx), %rcx
               	movq	$-0x1, %r8
               	xorl	%r9d, %r9d
               	movswq	(%rdi), %rdi
               	cmpl	%ecx, %edi
               	movq	%r9, %rcx
               	cmovgq	%r8, %rcx
               	movw	%cx, (%rsi)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0xd0(%rbp), %r9
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
               	leaq	-0xc0(%rbp), %rbx
               	leaq	-0x10(%rbp), %rdx
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdx
               	leaq	(%r9,%rcx), %rsi
               	addq	%rbx, %rcx
               	movl	(%rcx), %ecx
               	movq	$-0x1, %rdi
               	xorl	%r8d, %r8d
               	movl	(%rsi), %esi
               	cmpl	%ecx, %esi
               	movq	%r8, %rcx
               	cmovbq	%rdi, %rcx
               	movl	%ecx, (%rdx)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0xd0(%rbp), %rbx
               	leaq	-0xc0(%rbp), %r12
               	movups	-0xd0(%rbp), %xmm0
               	movups	-0xc0(%rbp), %xmm1
               	pcmpeqd	%xmm1, %xmm0
               	movups	%xmm0, -0x50(%rbp)
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	leaq	(%rdx,%rcx), %rsi
               	leaq	(%rbx,%rcx), %rdi
               	addq	%r12, %rcx
               	movl	(%rcx), %ecx
               	movq	$-0x1, %r8
               	xorl	%r9d, %r9d
               	movl	(%rdi), %edi
               	cmpl	%ecx, %edi
               	movq	%r9, %rcx
               	cmoveq	%r8, %rcx
               	movl	%ecx, (%rsi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0xb0(%rbp), %rbx
               	leaq	-0xa0(%rbp), %r12
               	movups	-0xa0(%rbp), %xmm0
               	movups	-0xb0(%rbp), %xmm1
               	pcmpgtd	%xmm1, %xmm0
               	movups	%xmm0, -0x50(%rbp)
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	leaq	(%rdx,%rcx), %rsi
               	leaq	(%rbx,%rcx), %rdi
               	addq	%r12, %rcx
               	movl	(%rcx), %ecx
               	movq	$-0x1, %r8
               	xorl	%r9d, %r9d
               	movl	(%rdi), %edi
               	cmpl	%ecx, %edi
               	movq	%r9, %rcx
               	cmovlq	%r8, %rcx
               	movl	%ecx, (%rsi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0xb0(%rbp), %r9
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
               	leaq	-0xa0(%rbp), %rbx
               	leaq	-0x10(%rbp), %rdx
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdx
               	leaq	(%r9,%rcx), %rsi
               	addq	%rbx, %rcx
               	movl	(%rcx), %ecx
               	movq	$-0x1, %rdi
               	xorl	%r8d, %r8d
               	movl	(%rsi), %esi
               	cmpl	%ecx, %esi
               	movq	%r8, %rcx
               	cmovgeq	%rdi, %rcx
               	movl	%ecx, (%rdx)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0xb0(%rbp), %r9
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
               	leaq	-0xa0(%rbp), %rbx
               	leaq	-0x10(%rbp), %rdx
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdx
               	leaq	(%r9,%rcx), %rsi
               	addq	%rbx, %rcx
               	movl	(%rcx), %ecx
               	movq	$-0x1, %rdi
               	xorl	%r8d, %r8d
               	movl	(%rsi), %esi
               	cmpl	%ecx, %esi
               	movq	%r8, %rcx
               	cmovneq	%rdi, %rcx
               	movl	%ecx, (%rdx)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x90(%rbp), %rbx
               	leaq	-0x80(%rbp), %r12
               	movq	-0x90(%rbp), %rax
               	movq	-0x80(%rbp), %rcx
               	cmpq	%rcx, %rax
               	setb	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	negq	%rcx
               	movq	-0x88(%rbp), %rsi
               	movq	-0x78(%rbp), %rdi
               	cmpq	%rdi, %rsi
               	setb	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movq	%rcx, -0x50(%rbp)
               	movq	%rsi, -0x48(%rbp)
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%rdx,%rcx), %rsi
               	leaq	(%rbx,%rcx), %rdi
               	addq	%r12, %rcx
               	movq	(%rcx), %rcx
               	movq	$-0x1, %r8
               	xorl	%r9d, %r9d
               	movq	(%rdi), %rdi
               	cmpq	%rcx, %rdi
               	movq	%r9, %rcx
               	cmovbq	%r8, %rcx
               	movq	%rcx, (%rsi)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x90(%rbp), %rbx
               	leaq	-0x80(%rbp), %r12
               	movq	-0x90(%rbp), %rax
               	movq	-0x80(%rbp), %rcx
               	cmpq	%rcx, %rax
               	seta	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	negq	%rcx
               	movq	-0x88(%rbp), %rsi
               	movq	-0x78(%rbp), %rdi
               	cmpq	%rdi, %rsi
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movq	%rcx, -0x50(%rbp)
               	movq	%rsi, -0x48(%rbp)
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%rdx,%rcx), %rsi
               	leaq	(%rbx,%rcx), %rdi
               	addq	%r12, %rcx
               	movq	(%rcx), %rcx
               	movq	$-0x1, %r8
               	xorl	%r9d, %r9d
               	movq	(%rdi), %rdi
               	cmpq	%rcx, %rdi
               	movq	%r9, %rcx
               	cmovaq	%r8, %rcx
               	movq	%rcx, (%rsi)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x70(%rbp), %rbx
               	leaq	-0x60(%rbp), %r12
               	movups	-0x60(%rbp), %xmm0
               	movups	-0x70(%rbp), %xmm1
               	pcmpgtq	%xmm1, %xmm0
               	movups	%xmm0, -0x50(%rbp)
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%rdx,%rcx), %rsi
               	leaq	(%rbx,%rcx), %rdi
               	addq	%r12, %rcx
               	movq	(%rcx), %rcx
               	movq	$-0x1, %r8
               	xorl	%r9d, %r9d
               	movq	(%rdi), %rdi
               	cmpq	%rcx, %rdi
               	movq	%r9, %rcx
               	cmovlq	%r8, %rcx
               	movq	%rcx, (%rsi)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x70(%rbp), %rbx
               	leaq	-0x60(%rbp), %r12
               	movups	-0x70(%rbp), %xmm0
               	movups	-0x60(%rbp), %xmm1
               	pcmpeqq	%xmm1, %xmm0
               	movups	%xmm0, -0x50(%rbp)
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%rdx,%rcx), %rsi
               	leaq	(%rbx,%rcx), %rdi
               	addq	%r12, %rcx
               	movq	(%rcx), %rcx
               	movq	$-0x1, %r8
               	xorl	%r9d, %r9d
               	movq	(%rdi), %rdi
               	cmpq	%rcx, %rdi
               	movq	%r9, %rcx
               	cmoveq	%r8, %rcx
               	movq	%rcx, (%rsi)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x28(%rbp), %r9
               	leaq	-0x20(%rbp), %rbx
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
               	leaq	-0x8(%rbp), %rcx
               	movzbq	(%rbx,%rax), %rdx
               	movq	$-0x1, %rsi
               	xorl	%edi, %edi
               	movzbq	(%r9,%rax), %r8
               	cmpl	%edx, %r8d
               	movq	%rdi, %rdx
               	cmovlq	%rsi, %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	-0x18(%rbp), %rcx
               	leaq	-0x8(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	-0x8(%rbp), %rax
               	leaq	<rip>, %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	leaq	-0x60(%rbp), %rdx
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x40(%rbp), %rsi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movss	-0x8(%rbp), %xmm0
               	movss	%xmm0, -0x58(%rbp)
               	movss	-0x60(%rbp), %xmm0
               	movss	-0x40(%rbp), %xmm1
               	ucomiss	%xmm1, %xmm0
               	sete	%cl
               	movzbq	%cl, %rcx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rcx
               	xorl	%eax, %eax
               	negq	%rcx
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
               	movl	%ecx, -0x50(%rbp)
               	movl	%edi, -0x4c(%rbp)
               	movl	%r8d, -0x48(%rbp)
               	movl	%r9d, -0x44(%rbp)
               	leaq	-0x10(%rbp), %rdi
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdi
               	leaq	(%rdx,%rcx), %r8
               	addq	%rsi, %rcx
               	movss	(%rcx), %xmm0
               	movq	$-0x1, %rcx
               	xorl	%r9d, %r9d
               	movss	(%r8), %xmm1
               	ucomiss	%xmm0, %xmm1
               	cmovneq	%r9, %rcx
               	cmovpq	%r9, %rcx
               	movl	%ecx, (%rdi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
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
               	leaq	-0x10(%rbp), %rdx
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdx
               	leaq	(%r8,%rcx), %rsi
               	addq	%r9, %rcx
               	movss	(%rcx), %xmm0
               	movq	$-0x1, %rcx
               	xorl	%edi, %edi
               	movss	(%rsi), %xmm1
               	ucomiss	%xmm0, %xmm1
               	movq	%rdi, %r10
               	cmovpq	%rcx, %r10
               	cmoveq	%r10, %rcx
               	movl	%ecx, (%rdx)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
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
               	leaq	-0x10(%rbp), %rdx
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdx
               	leaq	(%r8,%rcx), %rsi
               	addq	%r9, %rcx
               	movss	(%rcx), %xmm0
               	movq	$-0x1, %rcx
               	xorl	%edi, %edi
               	movss	(%rsi), %xmm1
               	comiss	%xmm1, %xmm0
               	cmovbeq	%rdi, %rcx
               	movl	%ecx, (%rdx)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
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
               	leaq	-0x10(%rbp), %rdx
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdx
               	leaq	(%r8,%rcx), %rsi
               	addq	%r9, %rcx
               	movss	(%rcx), %xmm0
               	movq	$-0x1, %rcx
               	xorl	%edi, %edi
               	movss	(%rsi), %xmm1
               	comiss	%xmm1, %xmm0
               	cmovbq	%rdi, %rcx
               	movl	%ecx, (%rdx)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
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
               	leaq	-0x10(%rbp), %rdx
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdx
               	leaq	(%r8,%rcx), %rsi
               	addq	%r9, %rcx
               	movss	(%rcx), %xmm0
               	movq	$-0x1, %rcx
               	xorl	%edi, %edi
               	movss	(%rsi), %xmm1
               	comiss	%xmm0, %xmm1
               	cmovbeq	%rdi, %rcx
               	movl	%ecx, (%rdx)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
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
               	leaq	-0x10(%rbp), %rdx
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdx
               	leaq	(%r8,%rcx), %rsi
               	addq	%r9, %rcx
               	movss	(%rcx), %xmm0
               	movq	$-0x1, %rcx
               	xorl	%edi, %edi
               	movss	(%rsi), %xmm1
               	comiss	%xmm0, %xmm1
               	cmovbq	%rdi, %rcx
               	movl	%ecx, (%rdx)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rdx
               	leaq	-0x10(%rbp), %rcx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x60(%rbp), %rbx
               	movl	$0x40000000, %edx       # imm = 0x40000000
               	movss	-0x60(%rbp), %xmm0
               	movq	%rdx, %xmm15
               	comiss	%xmm15, %xmm0
               	seta	%sil
               	movzbq	%sil, %rsi
               	xorl	%eax, %eax
               	negq	%rsi
               	movss	-0x5c(%rbp), %xmm0
               	movq	%rdx, %xmm15
               	comiss	%xmm15, %xmm0
               	seta	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movss	-0x58(%rbp), %xmm0
               	movq	%rdx, %xmm15
               	comiss	%xmm15, %xmm0
               	seta	%r8b
               	movzbq	%r8b, %r8
               	negq	%r8
               	movss	-0x54(%rbp), %xmm0
               	movq	%rdx, %xmm15
               	comiss	%xmm15, %xmm0
               	seta	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	%esi, -0x50(%rbp)
               	movl	%edi, -0x4c(%rbp)
               	movl	%r8d, -0x48(%rbp)
               	movl	%edx, -0x44(%rbp)
               	movq	%rax, %rdx
               	shlq	$0x2, %rdx
               	leaq	(%rcx,%rdx), %rsi
               	addq	%rbx, %rdx
               	movl	$0x40000000, %edi       # imm = 0x40000000
               	movq	$-0x1, %r8
               	xorl	%r9d, %r9d
               	movss	(%rdx), %xmm0
               	movq	%rdi, %xmm15
               	comiss	%xmm15, %xmm0
               	movq	%r9, %rdx
               	cmovaq	%r8, %rdx
               	movl	%edx, (%rsi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x8(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x60(%rbp), %rdx
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x40(%rbp), %rsi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movsd	-0x8(%rbp), %xmm0
               	movsd	%xmm0, -0x58(%rbp)
               	movsd	-0x60(%rbp), %xmm0
               	movsd	-0x40(%rbp), %xmm1
               	ucomisd	%xmm1, %xmm0
               	sete	%cl
               	movzbq	%cl, %rcx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rcx
               	xorl	%eax, %eax
               	negq	%rcx
               	movsd	-0x58(%rbp), %xmm0
               	movsd	-0x38(%rbp), %xmm1
               	ucomisd	%xmm1, %xmm0
               	sete	%dil
               	movzbq	%dil, %rdi
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rdi
               	negq	%rdi
               	movq	%rcx, -0x50(%rbp)
               	movq	%rdi, -0x48(%rbp)
               	leaq	-0x10(%rbp), %rdi
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rdi
               	leaq	(%rdx,%rcx), %r8
               	addq	%rsi, %rcx
               	movsd	(%rcx), %xmm0
               	movq	$-0x1, %rcx
               	xorl	%r9d, %r9d
               	movsd	(%r8), %xmm1
               	ucomisd	%xmm0, %xmm1
               	cmovneq	%r9, %rcx
               	cmovpq	%r9, %rcx
               	movq	%rcx, (%rdi)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x60(%rbp), %r9
               	leaq	-0x40(%rbp), %rbx
               	movsd	-0x60(%rbp), %xmm0
               	movsd	-0x40(%rbp), %xmm1
               	ucomisd	%xmm1, %xmm0
               	setne	%cl
               	movzbq	%cl, %rcx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rcx
               	xorl	%eax, %eax
               	negq	%rcx
               	movsd	-0x58(%rbp), %xmm0
               	movsd	-0x38(%rbp), %xmm1
               	ucomisd	%xmm1, %xmm0
               	setne	%sil
               	movzbq	%sil, %rsi
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rsi
               	negq	%rsi
               	movq	%rcx, -0x50(%rbp)
               	movq	%rsi, -0x48(%rbp)
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%rdx,%rcx), %rsi
               	leaq	(%r9,%rcx), %rdi
               	addq	%rbx, %rcx
               	movsd	(%rcx), %xmm0
               	movq	$-0x1, %rcx
               	xorl	%r8d, %r8d
               	movsd	(%rdi), %xmm1
               	ucomisd	%xmm0, %xmm1
               	movq	%r8, %r10
               	cmovpq	%rcx, %r10
               	cmoveq	%r10, %rcx
               	movq	%rcx, (%rsi)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x60(%rbp), %r9
               	leaq	-0x40(%rbp), %rbx
               	movsd	-0x60(%rbp), %xmm0
               	movsd	-0x40(%rbp), %xmm1
               	comisd	%xmm0, %xmm1
               	seta	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	negq	%rcx
               	movsd	-0x58(%rbp), %xmm0
               	movsd	-0x38(%rbp), %xmm1
               	comisd	%xmm0, %xmm1
               	seta	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movq	%rcx, -0x50(%rbp)
               	movq	%rsi, -0x48(%rbp)
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%rdx,%rcx), %rsi
               	leaq	(%r9,%rcx), %rdi
               	addq	%rbx, %rcx
               	movsd	(%rcx), %xmm0
               	movq	$-0x1, %rcx
               	xorl	%r8d, %r8d
               	movsd	(%rdi), %xmm1
               	comisd	%xmm1, %xmm0
               	cmovbeq	%r8, %rcx
               	movq	%rcx, (%rsi)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rdx
               	leaq	-0x10(%rbp), %rcx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x150(%rbp), %r8
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
               	movzbq	(%r8,%rax), %rdi
               	cmpl	$0x64, %edi
               	cmovleq	%rsi, %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rdx
               	leaq	-0x10(%rbp), %rcx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x150(%rbp), %r8
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
               	movzbq	(%r8,%rax), %rdi
               	cmpl	$0x3, %edi
               	cmovneq	%rsi, %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rdx
               	leaq	-0x10(%rbp), %rcx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x150(%rbp), %r8
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
               	movzbq	(%r8,%rax), %rdi
               	cmpl	$0xff, %edi
               	cmovgeq	%rsi, %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rdx
               	leaq	-0x10(%rbp), %rcx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x130(%rbp), %r8
               	movq	$-0x5, %rdx
               	leaq	-0x50(%rbp), %rsi
               	movsbq	-0x130(%rbp), %rax
               	cmpl	%edx, %eax
               	setg	%dil
               	movzbq	%dil, %rdi
               	xorl	%eax, %eax
               	negq	%rdi
               	movb	%dil, -0x50(%rbp)
               	movsbq	-0x12f(%rbp), %rdi
               	cmpl	%edx, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x4f(%rbp)
               	movsbq	-0x12e(%rbp), %rdi
               	cmpl	%edx, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x4e(%rbp)
               	movsbq	-0x12d(%rbp), %rdi
               	cmpl	%edx, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x4d(%rbp)
               	movsbq	-0x12c(%rbp), %rdi
               	cmpl	%edx, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x4c(%rbp)
               	movsbq	-0x12b(%rbp), %rdi
               	cmpl	%edx, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x4b(%rbp)
               	movsbq	-0x12a(%rbp), %rdi
               	cmpl	%edx, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x4a(%rbp)
               	movsbq	-0x129(%rbp), %rdi
               	cmpl	%edx, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x49(%rbp)
               	movsbq	-0x128(%rbp), %rdi
               	cmpl	%edx, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x48(%rbp)
               	movsbq	-0x127(%rbp), %rdi
               	cmpl	%edx, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x47(%rbp)
               	movsbq	-0x126(%rbp), %rdi
               	cmpl	%edx, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x46(%rbp)
               	movsbq	-0x125(%rbp), %rdi
               	cmpl	%edx, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x45(%rbp)
               	movsbq	-0x124(%rbp), %rdi
               	cmpl	%edx, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x44(%rbp)
               	movsbq	-0x123(%rbp), %rdi
               	cmpl	%edx, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x43(%rbp)
               	movsbq	-0x122(%rbp), %rdi
               	cmpl	%edx, %edi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movb	%dil, -0x42(%rbp)
               	movsbq	-0x121(%rbp), %rdi
               	cmpl	%edx, %edi
               	setg	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movb	%dl, -0x41(%rbp)
               	leaq	-0x40(%rbp), %rdx
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rdx)
               	movq	$-0x1, %rdx
               	xorl	%esi, %esi
               	movsbq	(%r8,%rax), %rdi
               	cmpl	$-0x5, %edi
               	cmovleq	%rsi, %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rdx
               	leaq	-0x10(%rbp), %rcx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0xb0(%rbp), %r9
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
               	movl	-0xa4(%rbp), %r8d
               	testl	%r8d, %r8d
               	setl	%r8b
               	movzbq	%r8b, %r8
               	negq	%r8
               	movl	%edx, -0x50(%rbp)
               	movl	%esi, -0x4c(%rbp)
               	movl	%edi, -0x48(%rbp)
               	movl	%r8d, -0x44(%rbp)
               	movq	%rax, %rdx
               	shlq	$0x2, %rdx
               	leaq	(%rcx,%rdx), %rsi
               	addq	%r9, %rdx
               	movq	$-0x1, %rdi
               	xorl	%r8d, %r8d
               	movl	(%rdx), %edx
               	testl	%edx, %edx
               	movq	%r8, %rdx
               	cmovlq	%rdi, %rdx
               	movl	%edx, (%rsi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rdx
               	leaq	-0x10(%rbp), %rcx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x90(%rbp), %r9
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
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	leaq	(%rcx,%rdx), %rsi
               	addq	%r9, %rdx
               	movq	$-0x1, %rdi
               	xorl	%r8d, %r8d
               	movq	(%rdx), %rdx
               	cmpq	$0x5, %rdx
               	movq	%r8, %rdx
               	cmovneq	%rdi, %rdx
               	movq	%rdx, (%rsi)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rdx
               	leaq	-0x10(%rbp), %rcx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x150(%rbp), %r8
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
               	movzbq	(%r8,%rax), %rdi
               	cmpl	$0x64, %edi
               	cmovgeq	%rsi, %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rdx
               	leaq	-0x10(%rbp), %rcx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	-0xb0(%rbp), %r9
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
               	movl	-0xa4(%rbp), %r8d
               	testl	%r8d, %r8d
               	setge	%r8b
               	movzbq	%r8b, %r8
               	negq	%r8
               	movl	%edx, -0x50(%rbp)
               	movl	%esi, -0x4c(%rbp)
               	movl	%edi, -0x48(%rbp)
               	movl	%r8d, -0x44(%rbp)
               	movq	%rax, %rdx
               	shlq	$0x2, %rdx
               	leaq	(%rcx,%rdx), %rsi
               	addq	%r9, %rdx
               	movq	$-0x1, %rdi
               	xorl	%r8d, %r8d
               	movl	(%rdx), %edx
               	testl	%edx, %edx
               	movq	%r8, %rdx
               	cmovgeq	%rdi, %rdx
               	movl	%edx, (%rsi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x50(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm0
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm1
               	movapd	%xmm1, %xmm2
               	pcmpgtd	%xmm0, %xmm2
               	pand	%xmm2, %xmm0
               	movq	$-0x1, %rax
               	vmovq	%rax, %xmm3
               	vpbroadcastq	%xmm3, %xmm3
               	pxor	%xmm3, %xmm2
               	pand	%xmm2, %xmm1
               	por	%xmm1, %xmm0
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
               	popq	%r12
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x31, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x30, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x2f, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x2e, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x2d, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x2c, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x2b, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x2a, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x29, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x28, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x27, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x26, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x25, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x24, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x23, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x22, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x21, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x20, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x1f, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x1e, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x1d, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x1c, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x1b, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x1a, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x19, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x18, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x17, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x16, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x15, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x14, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x13, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x12, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x11, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x10, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0xf, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0xe, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0xd, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0xc, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0xb, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0xa, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x9, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x8, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
