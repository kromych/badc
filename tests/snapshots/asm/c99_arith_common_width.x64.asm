
c99_arith_common_width.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
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
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r9
               	xorq	%r12, %r12
               	leaq	<rip>, %rdi
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	addq	$0x8, %rsi
               	leaq	<rip>, %rdi
               	movq	%rdi, (%rsi)
               	leaq	-0x18(%rbp), %r9
               	addq	$0x10, %r9
               	leaq	<rip>, %rdi
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rbx, %rdi
               	shlq	$0x3, %rdi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %r14
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	addq	%r12, %r14
               	movq	(%rax), %rax
               	movq	%rax, (%r14)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	shlq	$0x3, %rbx
               	addq	%rbx, %rax
               	movq	(%rax), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x130, %rsp            # imm = 0x130
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	addq	$0x1, %r11
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r11, %r10
               	movq	%r10, 0x68(%rsp)
               	jmp	<addr>
               	movq	0x68(%rsp), %r11
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	cmpq	$0x0, %r11
               	sete	%r11b
               	movzbq	%r11b, %r11
               	cmpq	$0x0, %r11
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	xorq	%rax, %rax
               	subq	$0x1, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%rax, %r10
               	movq	%r10, 0x60(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %r8
               	movl	$0x1, %r12d
               	movl	%r12d, (%r8)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	%rax, %r15
               	leaq	<rip>, %r14
               	movl	$0x1a, %ebx
               	movq	%r15, %rdi
               	movq	%r12, %rcx
               	movq	%rbx, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x60(%rsp), %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	movabsq	$-0x1, %rax
               	movl	$0x1, %r12d
               	subq	%r12, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%rax, %r10
               	movq	%r10, 0x58(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movl	$0x2, %ebx
               	movl	%ebx, (%r14)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r14
               	leaq	<rip>, %r15
               	movl	$0x21, %r12d
               	movq	%r14, %rdi
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x58(%rsp), %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	movl	$0xfffffffe, %r11d      # imm = 0xFFFFFFFE
               	cmpq	%r11, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	movabsq	$-0x1, %rax
               	movl	$0x1, %ebx
               	imulq	%rbx, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%rax, %r10
               	movq	%r10, 0x50(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movl	$0x3, %r12d
               	movl	%r12d, (%r15)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	<addr>
               	movq	%rax, %r14
               	leaq	<rip>, %r15
               	movl	$0x29, %ebx
               	movq	%r14, %rdi
               	movq	%r12, %rcx
               	movq	%rbx, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x50(%rsp), %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	movl	$0xc350, %eax           # imm = 0xC350
               	imulq	%rax, %rax
               	movslq	%eax, %r10
               	movq	%r10, 0x48(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movl	$0x4, %ebx
               	movl	%ebx, (%r15)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	<addr>
               	movq	%rax, %r14
               	leaq	<rip>, %r15
               	movl	$0x31, %r12d
               	movq	%r14, %rdi
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x48(%rsp), %rax
               	cmpq	$-0x6afd0700, %rax      # imm = 0x9502F900
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	movabsq	$-0x1, %rax
               	movl	$0x1, %ebx
               	addq	%rbx, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%rax, %r10
               	movq	%r10, 0x40(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movl	$0x5, %r12d
               	movl	%r12d, (%r15)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	<addr>
               	movq	%rax, %r14
               	leaq	<rip>, %r15
               	movl	$0x3e, %ebx
               	movq	%r14, %rdi
               	movq	%r12, %rcx
               	movq	%rbx, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x40(%rsp), %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	movabsq	$-0x1, %r10
               	movq	%r10, 0x30(%rsp)
               	movl	$0x1, %r10d
               	movq	%r10, 0x38(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movl	$0x64, %ebx
               	movl	%ebx, (%r15)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	<addr>
               	movq	%rax, %r14
               	leaq	<rip>, %r15
               	movl	$0x4b, %r12d
               	movq	%r14, %rdi
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x30(%rsp), %r15
               	movq	0x38(%rsp), %r10
               	cmpq	%r10, %r15
               	setl	%r15b
               	movzbq	%r15b, %r15
               	cmpq	$0x0, %r15
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	movabsq	$-0x1, %r10
               	movq	%r10, 0x20(%rsp)
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	movq	%r10, 0x28(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movl	$0x65, %r15d
               	movl	%r15d, (%r12)
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, %r14
               	leaq	<rip>, %r12
               	movl	$0x54, %ebx
               	movq	%r14, %rdi
               	movq	%r15, %rcx
               	movq	%rbx, %rdx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x20(%rsp), %r12
               	movq	0x28(%rsp), %r10
               	xorq	%r10, %r12
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r12
               	cmpq	$0x0, %r12
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	movl	$0x66, %r12d
               	movl	%r12d, (%rbx)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r14
               	leaq	<rip>, %rbx
               	movl	$0x5d, %r15d
               	movq	%r14, %rdi
               	movq	%r12, %rcx
               	movq	%r15, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movq	%r12, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	leaq	<rip>, %r12
               	movslq	(%r12), %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
