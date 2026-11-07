
atomic_operators_two_threads.x64:	file format elf64-x86-64

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

<worker>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x68, %rsp
               	pushq	%rbx
               	andq	$0xff, %rdi
               	leaq	-0x40(%rbp), %rax
               	movw	$0x0, (%rax)
               	movb	$0x0, 0x2(%rax)
               	movb	%dil, -0x40(%rbp)
               	movb	%dil, -0x3f(%rbp)
               	movb	%dil, -0x3e(%rbp)
               	xorl	%ebx, %ebx
               	leaq	<rip>, %rcx # <addr>
               	movl	$0x1, %eax
               	movq	%rax, %r10
               	lock
               	xaddl	%r10d, (%rcx)
               	leaq	<rip>, %rcx # <addr>
               	movq	%rax, %r10
               	negq	%r10
               	lock
               	xaddq	%r10, (%rcx)
               	leaq	<rip>, %rcx # <addr>
               	movq	%rax, %r10
               	lock
               	xaddb	%r10b, (%rcx)
               	leaq	<rip>, %rax # <addr>
               	movl	$0x8, %ecx
               	movq	%rcx, %r10
               	lock
               	xaddq	%r10, (%rax)
               	leaq	<rip>, %rdx # <addr>
               	movl	(%rdx), %ecx
               	jmp	<addr>
               	movq	%rax, %rcx
               	leaq	(%rcx,%rcx,2), %rsi
               	movl	%ecx, %eax
               	lock
               	cmpxchgl	%esi, (%rdx)
               	cmpl	%ecx, %eax
               	jne	<addr>
               	leaq	<rip>, %rdx # <addr>
               	movabsq	$0x3fe0000000000000, %rsi # imm = 0x3FE0000000000000
               	movq	(%rdx), %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	movq	%rcx, -0x38(%rbp)
               	movsd	-0x38(%rbp), %xmm0
               	movq	%rsi, %xmm15
               	addsd	%xmm15, %xmm0
               	movsd	%xmm0, -0x30(%rbp)
               	movq	-0x30(%rbp), %rdi
               	movq	%rcx, %rax
               	lock
               	cmpxchgq	%rdi, (%rdx)
               	cmpq	%rcx, %rax
               	jne	<addr>
               	leaq	<rip>, %rdx # <addr>
               	movabsq	$0x3fd0000000000000, %rsi # imm = 0x3FD0000000000000
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %rdi # <addr>
               	leaq	-0x28(%rbp), %rax
               	movq	%rcx, -0x28(%rbp)
               	movq	%rdi, -0x20(%rbp)
               	leaq	-0x60(%rbp), %rcx
               	fldt	-0x28(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movq	%rsi, %xmm15
               	addsd	%xmm15, %xmm0
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movsd	%xmm0, -0x8(%rsp)
               	fldl	-0x8(%rsp)
               	fstpt	-0x60(%rbp)
               	movq	%rax, %r10
               	pushq	%r10
               	movq	%rcx, %r10
               	movq	%rdx, %r11
               	pushq	%rbx
               	pushq	%rax
               	pushq	%rcx
               	pushq	%rdx
               	movq	(%r10), %rbx
               	movq	0x8(%r10), %rcx
               	movq	0x20(%rsp), %r10
               	movq	(%r10), %rax
               	movq	0x8(%r10), %rdx
               	lock
               	cmpxchg16b	(%r11)
               	je	<addr>
               	movq	%rax, (%r10)
               	movq	%rdx, 0x8(%r10)
               	sete	%cl
               	movzbq	%cl, %r10
               	popq	%rdx
               	popq	%rcx
               	popq	%rax
               	popq	%rbx
               	popq	%r11
               	movq	%r10, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %rdx # <addr>
               	leaq	-0x18(%rbp), %rax
               	movq	%rcx, -0x18(%rbp)
               	movq	%rdx, -0x10(%rbp)
               	leaq	-0x50(%rbp), %rcx
               	movq	-0x18(%rbp), %rdx
               	movq	-0x10(%rbp), %r8
               	leaq	0x1(%rdx), %rsi
               	cmpq	%rdx, %rsi
               	setb	%dl
               	movzbq	%dl, %rdx
               	incq	%r8
               	addq	%r8, %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movq	%rsi, -0x50(%rbp)
               	movq	%rdx, -0x48(%rbp)
               	movq	%rax, %r10
               	pushq	%r10
               	movq	%rcx, %r10
               	movq	%rdi, %r11
               	pushq	%rbx
               	pushq	%rax
               	pushq	%rcx
               	movq	(%r10), %rbx
               	movq	0x8(%r10), %rcx
               	movq	0x18(%rsp), %r10
               	movq	(%r10), %rax
               	movq	0x8(%r10), %rdx
               	lock
               	cmpxchg16b	(%r11)
               	je	<addr>
               	movq	%rax, (%r10)
               	movq	%rdx, 0x8(%r10)
               	sete	%cl
               	movzbq	%cl, %r10
               	popq	%rcx
               	popq	%rax
               	popq	%rbx
               	popq	%r11
               	movq	%r10, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	leaq	<rip>, %rdx # <addr>
               	movzbq	(%rdx), %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	movsbq	%cl, %rax
               	cmpq	$0x1, %rax
               	setne	%sil
               	movzbq	%sil, %rsi
               	movzbq	%cl, %rax
               	lock
               	cmpxchgb	%sil, (%rdx)
               	cmpl	%ecx, %eax
               	jne	<addr>
               	leaq	<rip>, %rsi # <addr>
               	leaq	-0x40(%rbp), %rdx
               	movl	$0x3, %edi
               	movl	$0x5, %ecx
               	callq	<addr>
               	leaq	<rip>, %rsi # <addr>
               	leaq	-0x8(%rbp), %rdx
               	movl	$0x3, %edi
               	movl	$0x5, %ecx
               	callq	<addr>
               	movzbq	-0x8(%rbp), %rcx
               	movzbq	-0x7(%rbp), %rax
               	movzbq	-0x6(%rbp), %rdx
               	cmpl	%eax, %ecx
               	jne	<addr>
               	cmpl	%edx, %eax
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movl	$0x1, %ecx
               	movq	%rcx, %r10
               	lock
               	xaddl	%r10d, (%rax)
               	incq	%rbx
               	cmpl	$0x4e20, %ebx           # imm = 0x4E20
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %rax # <addr>
               	leaq	<rip>, %rcx # <addr>
               	movq	%rcx, %r10
               	xchgq	%r10, (%rax)
               	xorl	%edi, %edi
               	movl	$0x2, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	<rip>, %rsi
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	<rip>, %rsi
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r12
               	testq	%rbx, %rbx
               	je	<addr>
               	testq	%r12, %r12
               	jne	<addr>
               	movl	$0x70, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x50(%rbp), %rdi
               	xorl	%esi, %esi
               	leaq	-<rip>, %rdx # <addr>
               	movl	$0x1, %ecx
               	callq	*%rbx
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	-0x50(%rbp), %rax
               	leaq	0x8(%rax), %rdi
               	xorl	%esi, %esi
               	leaq	-<rip>, %rdx # <addr>
               	movl	$0x2, %ecx
               	callq	*%rbx
               	testl	%eax, %eax
               	jne	<addr>
               	movq	-0x50(%rbp), %rdi
               	xorl	%esi, %esi
               	callq	*%r12
               	movq	-0x48(%rbp), %rdi
               	xorl	%esi, %esi
               	callq	*%r12
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax), %eax
               	cmpl	$0x9c40, %eax           # imm = 0x9C40
               	je	<addr>
               	movl	$0x71, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x72, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	movzbq	(%rax), %rax
               	cmpl	$0x40, %eax
               	je	<addr>
               	movl	$0x73, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %rax
               	leaq	<rip>, %rcx # <addr>
               	addq	$0x4e200, %rcx          # imm = 0x4E200
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x74, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%eax, %eax
               	movl	$0x1, %ecx
               	leaq	(%rcx,%rcx,2), %rcx
               	incq	%rax
               	cmpl	$0x9c40, %eax           # imm = 0x9C40
               	jl	<addr>
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax), %eax
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x77, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %rax
               	movq	%rax, -0x48(%rbp)
               	movsd	-0x48(%rbp), %xmm0
               	movabsq	$0x40d3880000000000, %rax # imm = 0x40D3880000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x78, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	leaq	-0x40(%rbp), %rdx
               	movq	%rax, -0x40(%rbp)
               	movq	%rax, -0x38(%rbp)
               	leaq	-0x30(%rbp), %rsi
               	movq	%rax, -0x30(%rbp)
               	movq	%rax, -0x28(%rbp)
               	movq	%rdx, %r10
               	pushq	%r10
               	movq	%rsi, %r10
               	movq	%rcx, %r11
               	pushq	%rbx
               	pushq	%rax
               	movq	(%r10), %rbx
               	movq	0x8(%r10), %rcx
               	movq	0x10(%rsp), %r10
               	movq	(%r10), %rax
               	movq	0x8(%r10), %rdx
               	lock
               	cmpxchg16b	(%r11)
               	je	<addr>
               	movq	%rax, (%r10)
               	movq	%rdx, 0x8(%r10)
               	sete	%cl
               	movzbq	%cl, %r10
               	popq	%rax
               	popq	%rbx
               	popq	%r11
               	fldt	-0x40(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	movabsq	$0x40c3880000000000, %rcx # imm = 0x40C3880000000000
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x79, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rcx # <addr>
               	leaq	-0x20(%rbp), %rdx
               	movq	%rax, -0x20(%rbp)
               	movq	%rax, -0x18(%rbp)
               	leaq	-0x10(%rbp), %rsi
               	movq	%rax, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	movq	%rdx, %r10
               	pushq	%r10
               	movq	%rsi, %r10
               	movq	%rcx, %r11
               	pushq	%rbx
               	pushq	%rax
               	movq	(%r10), %rbx
               	movq	0x8(%r10), %rcx
               	movq	0x10(%rsp), %r10
               	movq	(%r10), %rax
               	movq	0x8(%r10), %rdx
               	lock
               	cmpxchg16b	(%r11)
               	je	<addr>
               	movq	%rax, (%r10)
               	movq	%rdx, 0x8(%r10)
               	sete	%cl
               	movzbq	%cl, %r10
               	popq	%rax
               	popq	%rbx
               	popq	%r11
               	movq	-0x20(%rbp), %rcx
               	movq	-0x18(%rbp), %rdx
               	xorq	$0x9c40, %rcx           # imm = 0x9C40
               	xorq	$0x9c40, %rdx           # imm = 0x9C40
               	orq	%rdx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x7b, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movzbq	(%rcx), %rcx
               	movsbq	%cl, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x7d, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movl	(%rcx), %ecx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x7e, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
