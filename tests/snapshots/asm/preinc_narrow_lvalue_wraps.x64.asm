
preinc_narrow_lvalue_wraps.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movslq	%edi, %rbx
               	leaq	<rip>, %r9
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %r9
               	movq	(%r9), %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	leaq	<rip>, %r8
               	movq	%rbx, %r9
               	shlq	$0x3, %r9
               	addq	%r9, %r8
               	movq	(%r8), %r8
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r9
               	xorq	%rdi, %rdi
               	leaq	<rip>, %r8
               	movq	%r8, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	addq	$0x8, %rsi
               	leaq	<rip>, %r8
               	movq	%r8, (%rsi)
               	leaq	-0x18(%rbp), %r9
               	addq	$0x10, %r9
               	leaq	<rip>, %r8
               	movq	%r8, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %rsi
               	movq	(%rsi), %r8
               	movq	%r8, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rdi
               	movq	(%rax), %rax
               	movq	%rax, (%rdi)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	shlq	$0x3, %rbx
               	addq	%rbx, %rax
               	movq	(%rax), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movl	$0xff, %r11d
               	movb	%r11b, -0x8(%rbp)
               	xorq	%r9, %r9
               	movl	%r9d, -0x10(%rbp)
               	leaq	-0x8(%rbp), %r11
               	movzbq	(%r11), %r9
               	addq	$0x1, %r9
               	movb	%r9b, (%r11)
               	movzbq	(%r11), %r11
               	cmpq	$0x0, %r11
               	jne	<addr>
               	movl	$0x1, %r8d
               	movl	%r8d, -0x10(%rbp)
               	jmp	<addr>
               	movslq	-0x10(%rbp), %r8
               	cmpq	$0x1, %r8
               	sete	%r8b
               	movzbq	%r8b, %r8
               	movq	%r8, -0x18(%rbp)
               	cmpq	$0x0, %r8
               	je	<addr>
               	movzbq	-0x8(%rbp), %r11
               	cmpq	$0x0, %r11
               	sete	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0x18(%rbp)
               	jmp	<addr>
               	movq	-0x18(%rbp), %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	xorq	%r8, %r8
               	movq	%r8, -0x20(%rbp)
               	jmp	<addr>
               	movl	$0x1, %r8d
               	movq	%r8, -0x20(%rbp)
               	jmp	<addr>
               	movq	-0x20(%rbp), %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movl	$0xffff, %r11d          # imm = 0xFFFF
               	movw	%r11w, -0x8(%rbp)
               	xorq	%r9, %r9
               	movl	%r9d, -0x10(%rbp)
               	leaq	-0x8(%rbp), %r11
               	movzwq	(%r11), %r9
               	addq	$0x1, %r9
               	movw	%r9w, (%r11)
               	movzwq	(%r11), %r11
               	cmpq	$0x0, %r11
               	jne	<addr>
               	movl	$0x1, %r8d
               	movl	%r8d, -0x10(%rbp)
               	jmp	<addr>
               	movslq	-0x10(%rbp), %r8
               	cmpq	$0x1, %r8
               	sete	%r8b
               	movzbq	%r8b, %r8
               	movq	%r8, -0x18(%rbp)
               	cmpq	$0x0, %r8
               	je	<addr>
               	movzwq	-0x8(%rbp), %r11
               	cmpq	$0x0, %r11
               	sete	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0x18(%rbp)
               	jmp	<addr>
               	movq	-0x18(%rbp), %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	xorq	%r8, %r8
               	movq	%r8, -0x20(%rbp)
               	jmp	<addr>
               	movl	$0x1, %r8d
               	movq	%r8, -0x20(%rbp)
               	jmp	<addr>
               	movq	-0x20(%rbp), %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	movl	%r11d, -0x8(%rbp)
               	xorq	%r9, %r9
               	movl	%r9d, -0x10(%rbp)
               	leaq	-0x8(%rbp), %r11
               	movl	(%r11), %r9d
               	addq	$0x1, %r9
               	movl	%r9d, (%r11)
               	movl	(%r11), %r11d
               	cmpq	$0x0, %r11
               	jne	<addr>
               	movl	$0x1, %r8d
               	movl	%r8d, -0x10(%rbp)
               	jmp	<addr>
               	movslq	-0x10(%rbp), %r8
               	cmpq	$0x1, %r8
               	sete	%r8b
               	movzbq	%r8b, %r8
               	movq	%r8, -0x18(%rbp)
               	cmpq	$0x0, %r8
               	je	<addr>
               	movl	-0x8(%rbp), %r11d
               	cmpq	$0x0, %r11
               	sete	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0x18(%rbp)
               	jmp	<addr>
               	movq	-0x18(%rbp), %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	xorq	%r8, %r8
               	movq	%r8, -0x20(%rbp)
               	jmp	<addr>
               	movl	$0x1, %r8d
               	movq	%r8, -0x20(%rbp)
               	jmp	<addr>
               	movq	-0x20(%rbp), %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movl	$0xf0, %r11d
               	movb	%r11b, -0x8(%rbp)
               	xorq	%r9, %r9
               	movl	%r9d, -0x10(%rbp)
               	leaq	-0x8(%rbp), %r11
               	movzbq	(%r11), %r9
               	addq	$0x10, %r9
               	movb	%r9b, (%r11)
               	movzbq	(%r11), %r11
               	cmpq	$0x0, %r11
               	jne	<addr>
               	movl	$0x1, %r8d
               	movl	%r8d, -0x10(%rbp)
               	jmp	<addr>
               	movslq	-0x10(%rbp), %r8
               	cmpq	$0x1, %r8
               	sete	%r8b
               	movzbq	%r8b, %r8
               	movq	%r8, -0x18(%rbp)
               	cmpq	$0x0, %r8
               	je	<addr>
               	movzbq	-0x8(%rbp), %r11
               	cmpq	$0x0, %r11
               	sete	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0x18(%rbp)
               	jmp	<addr>
               	movq	-0x18(%rbp), %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	xorq	%r8, %r8
               	movq	%r8, -0x20(%rbp)
               	jmp	<addr>
               	movl	$0x1, %r8d
               	movq	%r8, -0x20(%rbp)
               	jmp	<addr>
               	movq	-0x20(%rbp), %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movl	$0xfff0, %r11d          # imm = 0xFFF0
               	movw	%r11w, -0x8(%rbp)
               	xorq	%r9, %r9
               	movl	%r9d, -0x10(%rbp)
               	leaq	-0x8(%rbp), %r11
               	movzwq	(%r11), %r9
               	addq	$0x10, %r9
               	movw	%r9w, (%r11)
               	movzwq	(%r11), %r11
               	cmpq	$0x0, %r11
               	jne	<addr>
               	movl	$0x1, %r8d
               	movl	%r8d, -0x10(%rbp)
               	jmp	<addr>
               	movslq	-0x10(%rbp), %r8
               	cmpq	$0x1, %r8
               	sete	%r8b
               	movzbq	%r8b, %r8
               	movq	%r8, -0x18(%rbp)
               	cmpq	$0x0, %r8
               	je	<addr>
               	movzwq	-0x8(%rbp), %r11
               	cmpq	$0x0, %r11
               	sete	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0x18(%rbp)
               	jmp	<addr>
               	movq	-0x18(%rbp), %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	xorq	%r8, %r8
               	movq	%r8, -0x20(%rbp)
               	jmp	<addr>
               	movl	$0x1, %r8d
               	movq	%r8, -0x20(%rbp)
               	jmp	<addr>
               	movq	-0x20(%rbp), %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movl	$0xff, %r11d
               	movb	%r11b, -0x8(%rbp)
               	leaq	-0x8(%rbp), %r9
               	xorq	%r11, %r11
               	movl	%r11d, -0x18(%rbp)
               	movzbq	(%r9), %r8
               	addq	$0x1, %r8
               	movb	%r8b, (%r9)
               	movzbq	(%r9), %r9
               	cmpq	$0x0, %r9
               	jne	<addr>
               	movl	$0x1, %r11d
               	movl	%r11d, -0x18(%rbp)
               	jmp	<addr>
               	movslq	-0x18(%rbp), %r11
               	cmpq	$0x1, %r11
               	sete	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0x20(%rbp)
               	cmpq	$0x0, %r11
               	je	<addr>
               	movzbq	-0x8(%rbp), %r9
               	cmpq	$0x0, %r9
               	sete	%r9b
               	movzbq	%r9b, %r9
               	movq	%r9, -0x20(%rbp)
               	jmp	<addr>
               	movq	-0x20(%rbp), %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	xorq	%r11, %r11
               	movq	%r11, -0x28(%rbp)
               	jmp	<addr>
               	movl	$0x1, %r11d
               	movq	%r11, -0x28(%rbp)
               	jmp	<addr>
               	movq	-0x28(%rbp), %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	xorq	%r11, %r11
               	movl	%r11d, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rbx
               	movslq	(%rbx), %r12
               	callq	<addr>
               	orq	%rax, %r12
               	movl	%r12d, (%rbx)
               	leaq	-0x8(%rbp), %r14
               	movslq	(%r14), %rbx
               	callq	<addr>
               	orq	%rax, %rbx
               	movl	%ebx, (%r14)
               	leaq	-0x8(%rbp), %r12
               	movslq	(%r12), %r14
               	callq	<addr>
               	orq	%rax, %r14
               	movl	%r14d, (%r12)
               	leaq	-0x8(%rbp), %rbx
               	movslq	(%rbx), %r12
               	callq	<addr>
               	orq	%rax, %r12
               	movl	%r12d, (%rbx)
               	leaq	-0x8(%rbp), %r14
               	movslq	(%r14), %rbx
               	callq	<addr>
               	orq	%rax, %rbx
               	movl	%ebx, (%r14)
               	leaq	-0x8(%rbp), %r12
               	movslq	(%r12), %r14
               	callq	<addr>
               	orq	%rax, %r14
               	movl	%r14d, (%r12)
               	leaq	<rip>, %rdi
               	movslq	-0x8(%rbp), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movslq	-0x8(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
