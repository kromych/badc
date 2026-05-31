
clock_monotonic_advances.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400297 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe41(%rip)           # 0x4100d8
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	leaq	-0x10(%rbp), %r11
               	movabsq	$-0x1, %r9
               	movq	%r9, (%r11)
               	leaq	-0x10(%rbp), %r8
               	movq	%r8, %r11
               	addq	$0x8, %r11
               	movq	%r9, (%r11)
               	movl	$0x1, %ebx
               	leaq	-0x10(%rbp), %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	0x400737 <clock_gettime>
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	je	0x40031a <.text+0x9a>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r12
               	movq	(%r12), %rax
               	cmpq	$-0x1, %rax
               	sete	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x48(%rbp)
               	cmpq	$0x0, %r12
               	je	0x40036c <.text+0xec>
               	leaq	-0x10(%rbp), %rax
               	movq	%rax, %r12
               	addq	$0x8, %r12
               	movq	(%r12), %rax
               	cmpq	$-0x1, %rax
               	sete	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x48(%rbp)
               	jmp	0x40036c <.text+0xec>
               	movq	-0x48(%rbp), %r12
               	cmpq	$0x0, %r12
               	je	0x40039f <.text+0x11f>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r12
               	movq	(%r12), %rax
               	cmpq	$0x0, %rax
               	jge	0x4003d6 <.text+0x156>
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r12
               	movq	%r12, %rax
               	addq	$0x8, %rax
               	movq	(%rax), %r12
               	cmpq	$0x0, %r12
               	setl	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x50(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x400430 <.text+0x1b0>
               	leaq	-0x10(%rbp), %r12
               	movq	%r12, %rax
               	addq	$0x8, %rax
               	movq	(%rax), %r12
               	cmpq	$0x3b9aca00, %r12       # imm = 0x3B9ACA00
               	setge	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x50(%rbp)
               	jmp	0x400430 <.text+0x1b0>
               	movq	-0x50(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	0x400464 <.text+0x1e4>
               	movl	$0x4, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movl	%eax, -0x28(%rbp)
               	movl	%eax, -0x30(%rbp)
               	jmp	0x400472 <.text+0x1f2>
               	movslq	-0x30(%rbp), %rax
               	cmpq	$0xf4240, %rax          # imm = 0xF4240
               	jge	0x4004ba <.text+0x23a>
               	jmp	0x4004a0 <.text+0x220>
               	leaq	-0x30(%rbp), %rax
               	movslq	(%rax), %r12
               	movq	%r12, %rbx
               	addq	$0x1, %rbx
               	movl	%ebx, (%rax)
               	jmp	0x400472 <.text+0x1f2>
               	movslq	-0x28(%rbp), %rbx
               	movq	%rbx, %r12
               	addq	$0x1, %r12
               	movslq	%r12d, %r12
               	movl	%r12d, -0x28(%rbp)
               	jmp	0x400488 <.text+0x208>
               	movl	$0x1, %r14d
               	leaq	-0x20(%rbp), %r12
               	movq	%r14, %rdi
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	0x400737 <clock_gettime>
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	je	0x400503 <.text+0x283>
               	movl	$0x5, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %r12
               	movq	(%r12), %rax
               	leaq	-0x10(%rbp), %r12
               	movq	(%r12), %r14
               	cmpq	%r14, %rax
               	jge	0x40053f <.text+0x2bf>
               	movl	$0x6, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %r12
               	movq	(%r12), %r14
               	leaq	-0x10(%rbp), %r12
               	movq	(%r12), %rax
               	cmpq	%rax, %r14
               	sete	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x58(%rbp)
               	cmpq	$0x0, %r12
               	je	0x4005a2 <.text+0x322>
               	leaq	-0x20(%rbp), %rax
               	movq	%rax, %r12
               	addq	$0x8, %r12
               	movq	(%r12), %rax
               	leaq	-0x10(%rbp), %r12
               	movq	%r12, %r14
               	addq	$0x8, %r14
               	movq	(%r14), %r12
               	cmpq	%r12, %rax
               	setl	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0x58(%rbp)
               	jmp	0x4005a2 <.text+0x322>
               	movq	-0x58(%rbp), %r14
               	cmpq	$0x0, %r14
               	je	0x4005d6 <.text+0x356>
               	movl	$0x7, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	xorq	%r14, %r14
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
