
zero_sign_extension_32bit.x64:	file format elf64-x86-64

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
               	movq	(%r9), %r8
               	cmpq	$0x0, %r8
               	je	<addr>
               	leaq	<rip>, %r9
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %r9
               	movq	(%r9), %r8
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
               	movq	(%rax), %r12
               	movq	%r12, (%r14)
               	jmp	<addr>
               	leaq	<rip>, %r12
               	shlq	$0x3, %rbx
               	addq	%rbx, %r12
               	movq	(%r12), %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x1d0, %rsp            # imm = 0x1D0
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movabsq	$-0x1, %r10
               	movq	%r10, 0xc8(%rsp)
               	movq	0xc8(%rsp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, 0xc0(%rsp)
               	jmp	<addr>
               	movq	0xc0(%rsp), %r8
               	cmpq	$-0x1, %r8
               	sete	%r8b
               	movzbq	%r8b, %r8
               	cmpq	$0x0, %r8
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x1, %r14d
               	movl	%r14d, (%rdi)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	<rip>, %r15
               	movl	$0x1b, %r12d
               	movq	%rbx, %rdi
               	movq	%r14, %rcx
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0xc8(%rsp), %rax
               	movslq	%eax, %rax
               	cmpq	$-0x1, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	movq	%r10, 0xb8(%rsp)
               	movq	0xb8(%rsp), %r10
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r10
               	movq	%r10, 0xb0(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movl	$0x2, %r14d
               	movl	%r14d, (%r12)
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	<rip>, %r15
               	movl	$0x1c, %r12d
               	movq	%rbx, %rdi
               	movq	%r14, %rcx
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0xb0(%rsp), %r15
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %r15
               	sete	%r15b
               	movzbq	%r15b, %r15
               	cmpq	$0x0, %r15
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movl	$0x3, %r15d
               	movl	%r15d, (%r12)
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, %r14
               	leaq	<rip>, %r12
               	movl	$0x20, %ebx
               	movq	%r14, %rdi
               	movq	%r15, %rcx
               	movq	%rbx, %rdx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0xb8(%rsp), %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	movabsq	$-0x7, %r10
               	movq	%r10, 0xa8(%rsp)
               	movq	0xa8(%rsp), %r14
               	movslq	%r14d, %r14
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r14, %r10
               	movq	%r10, 0xa0(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	movl	$0x4, %r15d
               	movl	%r15d, (%rbx)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	<rip>, %rbx
               	movl	$0x21, %r14d
               	movq	%r12, %rdi
               	movq	%r15, %rcx
               	movq	%r14, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0xa0(%rsp), %rbx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rbx
               	movl	$0xfffffff9, %r11d      # imm = 0xFFFFFFF9
               	cmpq	%r11, %rbx
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	movq	0xa0(%rsp), %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	movslq	%eax, %r10
               	movq	%r10, 0x98(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movl	$0xa, %ebx
               	movl	%ebx, (%r12)
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, %r15
               	leaq	<rip>, %r12
               	movl	$0x28, %r14d
               	movq	%r15, %rdi
               	movq	%rbx, %rcx
               	movq	%r14, %rdx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x98(%rsp), %rax
               	movslq	%eax, %rax
               	cmpq	$-0x7, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	movq	0xa8(%rsp), %rax
               	movslq	%eax, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%rax, %r10
               	movq	%r10, 0x90(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movl	$0xb, %r14d
               	movl	%r14d, (%r12)
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, %r15
               	leaq	<rip>, %r12
               	movl	$0x2a, %ebx
               	movq	%r15, %rdi
               	movq	%r14, %rcx
               	movq	%rbx, %rdx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x90(%rsp), %rax
               	movl	$0xfffffff9, %r11d      # imm = 0xFFFFFFF9
               	cmpq	%r11, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	movl	$0xf4240, %eax          # imm = 0xF4240
               	movl	$0xbb8, %r14d           # imm = 0xBB8
               	movslq	%eax, %rax
               	movslq	%r14d, %r14
               	imulq	%r14, %rax
               	movslq	%eax, %r10
               	movq	%r10, 0x88(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movl	$0xc, %ebx
               	movl	%ebx, (%r12)
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, %r15
               	leaq	<rip>, %r12
               	movl	$0x30, %r14d
               	movq	%r15, %rdi
               	movq	%rbx, %rcx
               	movq	%r14, %rdx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x88(%rsp), %rax
               	movslq	%eax, %rax
               	cmpq	$-0x4d2fa200, %rax      # imm = 0xB2D05E00
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movl	$0x14, %r14d
               	movl	%r14d, (%r12)
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, %r15
               	leaq	<rip>, %r12
               	movl	$0x3a, %ebx
               	movq	%r15, %rdi
               	movq	%r14, %rcx
               	movq	%rbx, %rdx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x88(%rsp), %rax
               	movslq	%eax, %rax
               	cmpq	$-0x4d2fa200, %rax      # imm = 0xB2D05E00
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	<addr>
               	movl	$0x10000, %eax          # imm = 0x10000
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%rax, %r15
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	imulq	%rax, %r15
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r15, %r10
               	movq	%r10, 0x80(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	movl	$0x15, %r14d
               	movl	%r14d, (%rbx)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	<rip>, %rbx
               	movl	$0x3b, %r15d
               	movq	%r12, %rdi
               	movq	%r14, %rcx
               	movq	%r15, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x80(%rsp), %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	movl	$0x16, %r14d
               	movl	%r14d, (%rbx)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	<rip>, %rbx
               	movl	$0x40, %r15d
               	movq	%r12, %rdi
               	movq	%r14, %rcx
               	movq	%r15, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x80(%rsp), %rax
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
               	movl	$0x80000000, %eax       # imm = 0x80000000
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	movq	%rax, %r10
               	shrq	$0x1, %r10
               	movq	%r10, 0x78(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movl	$0x17, %r14d
               	movl	%r14d, (%r15)
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	<rip>, %r15
               	movl	$0x41, %r12d
               	movq	%rbx, %rdi
               	movq	%r14, %rcx
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x78(%rsp), %rax
               	cmpq	$0x40000000, %rax       # imm = 0x40000000
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	movl	$0x12345678, %eax       # imm = 0x12345678
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	shlq	$0x4, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%rax, %r10
               	movq	%r10, 0x70(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movl	$0x1e, %r12d
               	movl	%r12d, (%r15)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	<rip>, %r15
               	movl	$0x4a, %r14d
               	movq	%rbx, %rdi
               	movq	%r12, %rcx
               	movq	%r14, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x70(%rsp), %rax
               	cmpq	$0x23456780, %rax       # imm = 0x23456780
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	xorq	%rax, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	xorq	$-0x1, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%rax, %r10
               	movq	%r10, 0x68(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movl	$0x1f, %r14d
               	movl	%r14d, (%r15)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	<rip>, %r15
               	movl	$0x4f, %r12d
               	movq	%rbx, %rdi
               	movq	%r14, %rcx
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x68(%rsp), %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	leaq	<rip>, %r12
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %r10
               	movq	%r10, 0x60(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movl	$0x20, %r12d
               	movl	%r12d, (%r15)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	<rip>, %r15
               	movl	$0x54, %r14d
               	movq	%rbx, %rdi
               	movq	%r12, %rcx
               	movq	%r14, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x60(%rsp), %r12
               	movslq	%r12d, %r12
               	cmpq	$-0x7fffffff, %r12      # imm = 0x80000001
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movl	$0x28, %r14d
               	movl	%r14d, (%r15)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	<rip>, %r15
               	movl	$0x5d, %ebx
               	movq	%r12, %rdi
               	movq	%r14, %rcx
               	movq	%rbx, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x60(%rsp), %rax
               	movslq	%eax, %rax
               	cmpq	$-0x7fffffff, %rax      # imm = 0x80000001
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	movabsq	$-0x1, %r10
               	movq	%r10, 0x48(%rsp)
               	movl	$0x1, %r10d
               	movq	%r10, 0x58(%rsp)
               	movq	0x48(%rsp), %rbx
               	movslq	%ebx, %rbx
               	movq	0x58(%rsp), %r12
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r12
               	addq	%r12, %rbx
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%rbx, %r10
               	movq	%r10, 0x50(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	movl	$0x29, %r14d
               	movl	%r14d, (%rbx)
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, %r15
               	leaq	<rip>, %rbx
               	movl	$0x5e, %r12d
               	movq	%r15, %rdi
               	movq	%r14, %rcx
               	movq	%r12, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x50(%rsp), %r12
               	cmpq	$0x0, %r12
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	movq	0x48(%rsp), %rax
               	movslq	%eax, %rax
               	movq	0x58(%rsp), %r14
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r14
               	subq	%r14, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%rax, %r10
               	movq	%r10, 0x40(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x32, %r12d
               	movl	%r12d, (%rax)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	<rip>, %r15
               	movl	$0x68, %r14d
               	movq	%rbx, %rdi
               	movq	%r12, %rcx
               	movq	%r14, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x40(%rsp), %rax
               	movl	$0xfffffffe, %r11d      # imm = 0xFFFFFFFE
               	cmpq	%r11, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	movl	$0x12345678, %r10d      # imm = 0x12345678
               	movq	%r10, 0x38(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movl	$0x33, %r14d
               	movl	%r14d, (%r15)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	<rip>, %r15
               	movl	$0x6c, %r12d
               	movq	%rbx, %rdi
               	movq	%r14, %rcx
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x38(%rsp), %r12
               	movslq	%r12d, %r12
               	cmpq	$0x12345678, %r12       # imm = 0x12345678
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	movq	0x38(%rsp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, 0x30(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movl	$0x3c, %ebx
               	movl	%ebx, (%r15)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	<rip>, %r15
               	movl	$0x73, %r14d
               	movq	%r12, %rdi
               	movq	%rbx, %rcx
               	movq	%r14, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x30(%rsp), %r14
               	cmpq	$0x12345678, %r14       # imm = 0x12345678
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	movabsq	$-0x77359400, %r10      # imm = 0x88CA6C00
               	movq	%r10, 0x28(%rsp)
               	movq	0x28(%rsp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, 0x20(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movl	$0x3d, %r12d
               	movl	%r12d, (%r15)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	<addr>
               	movq	%rax, %r14
               	leaq	<rip>, %r15
               	movl	$0x75, %ebx
               	movq	%r14, %rdi
               	movq	%r12, %rcx
               	movq	%rbx, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x20(%rsp), %r15
               	cmpq	$-0x77359400, %r15      # imm = 0x88CA6C00
               	sete	%r15b
               	movzbq	%r15b, %r15
               	cmpq	$0x0, %r15
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	movl	$0x3e, %r15d
               	movl	%r15d, (%rbx)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	<rip>, %rbx
               	movl	$0x7a, %r14d
               	movq	%r12, %rdi
               	movq	%r15, %rcx
               	movq	%r14, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x28(%rsp), %rax
               	movslq	%eax, %rax
               	cmpq	$-0x77359400, %rax      # imm = 0x88CA6C00
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movl	$0x3f, %r15d
               	movl	%r15d, (%r14)
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	<rip>, %r14
               	movl	$0x7b, %r12d
               	movq	%rbx, %rdi
               	movq	%r15, %rcx
               	movq	%r12, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movq	%r15, %rdi
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
               	addq	$0x1d0, %rsp            # imm = 0x1D0
               	popq	%rbp
               	retq
               	leaq	<rip>, %r15
               	movslq	(%r15), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x1d0, %rsp            # imm = 0x1D0
               	popq	%rbp
               	retq
