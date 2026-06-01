
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
               	subq	$0x1b0, %rsp            # imm = 0x1B0
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movabsq	$-0x1, %r10
               	movq	%r10, 0xa8(%rsp)
               	jmp	<addr>
               	movq	0xa8(%rsp), %r9
               	cmpq	$-0x1, %r9
               	sete	%r9b
               	movzbq	%r9b, %r9
               	cmpq	$0x0, %r9
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r8
               	movl	$0x1, %r12d
               	movl	%r12d, (%r8)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	%rax, %r15
               	leaq	<rip>, %r14
               	movl	$0x1b, %ebx
               	movq	%r15, %rdi
               	movq	%r12, %rcx
               	movq	%rbx, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0xa8(%rsp), %rax
               	cmpq	$-0x1, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	movq	%r10, 0xa0(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	movl	$0x2, %r12d
               	movl	%r12d, (%rbx)
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, %r15
               	leaq	<rip>, %r14
               	movl	$0x1c, %ebx
               	movq	%r15, %rdi
               	movq	%r12, %rcx
               	movq	%rbx, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0xa0(%rsp), %rbx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rbx
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movl	$0x3, %r15d
               	movl	%r15d, (%r14)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	<rip>, %r14
               	movl	$0x20, %r12d
               	movq	%rbx, %rdi
               	movq	%r15, %rcx
               	movq	%r12, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0xa0(%rsp), %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	movabsq	$-0x7, %r10
               	movq	%r10, 0x98(%rsp)
               	movq	0x98(%rsp), %r10
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r10
               	movq	%r10, 0x90(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movl	$0x4, %r15d
               	movl	%r15d, (%r12)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r14
               	leaq	<rip>, %r12
               	movl	$0x21, %ebx
               	movq	%r14, %rdi
               	movq	%r15, %rcx
               	movq	%rbx, %rdx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x90(%rsp), %r12
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r12
               	movl	$0xfffffff9, %r11d      # imm = 0xFFFFFFF9
               	cmpq	%r11, %r12
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	movq	0x90(%rsp), %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	movslq	%eax, %r10
               	movq	%r10, 0x88(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	movl	$0xa, %r12d
               	movl	%r12d, (%rbx)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r15
               	leaq	<rip>, %rbx
               	movl	$0x28, %r14d
               	movq	%r15, %rdi
               	movq	%r12, %rcx
               	movq	%r14, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x88(%rsp), %rax
               	movslq	%eax, %rax
               	cmpq	$-0x7, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	movq	0x98(%rsp), %r10
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r10
               	movq	%r10, 0x80(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	movl	$0xb, %r14d
               	movl	%r14d, (%rbx)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r15
               	leaq	<rip>, %rbx
               	movl	$0x2a, %r12d
               	movq	%r15, %rdi
               	movq	%r14, %rcx
               	movq	%r12, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x80(%rsp), %r12
               	movl	$0xfffffff9, %r11d      # imm = 0xFFFFFFF9
               	cmpq	%r11, %r12
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	movl	$0xf4240, %eax          # imm = 0xF4240
               	movl	$0xbb8, %r14d           # imm = 0xBB8
               	imulq	%r14, %rax
               	movslq	%eax, %r10
               	movq	%r10, 0x78(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	movl	$0xc, %r15d
               	movl	%r15d, (%rbx)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	<rip>, %rbx
               	movl	$0x30, %r14d
               	movq	%r12, %rdi
               	movq	%r15, %rcx
               	movq	%r14, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x78(%rsp), %rax
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
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	movl	$0x14, %r14d
               	movl	%r14d, (%rbx)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	<rip>, %rbx
               	movl	$0x3a, %r15d
               	movq	%r12, %rdi
               	movq	%r14, %rcx
               	movq	%r15, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x78(%rsp), %rax
               	movslq	%eax, %rax
               	cmpq	$-0x4d2fa200, %rax      # imm = 0xB2D05E00
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	movl	$0x10000, %eax          # imm = 0x10000
               	imulq	%rax, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%rax, %r10
               	movq	%r10, 0x70(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movl	$0x15, %r14d
               	movl	%r14d, (%r15)
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	<rip>, %r15
               	movl	$0x3b, %r12d
               	movq	%rbx, %rdi
               	movq	%r14, %rcx
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x70(%rsp), %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movl	$0x16, %r12d
               	movl	%r12d, (%r15)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	<rip>, %r15
               	movl	$0x40, %r14d
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
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	movl	$0x80000000, %eax       # imm = 0x80000000
               	movq	%rax, %r10
               	shrq	$0x1, %r10
               	movq	%r10, 0x68(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movl	$0x17, %r12d
               	movl	%r12d, (%r14)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r15
               	leaq	<rip>, %r14
               	movl	$0x41, %ebx
               	movq	%r15, %rdi
               	movq	%r12, %rcx
               	movq	%rbx, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x68(%rsp), %rax
               	cmpq	$0x40000000, %rax       # imm = 0x40000000
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	movl	$0x12345678, %eax       # imm = 0x12345678
               	shlq	$0x4, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%rax, %r10
               	movq	%r10, 0x60(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movl	$0x1e, %ebx
               	movl	%ebx, (%r14)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	%rax, %r15
               	leaq	<rip>, %r14
               	movl	$0x4a, %r12d
               	movq	%r15, %rdi
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x60(%rsp), %rax
               	cmpq	$0x23456780, %rax       # imm = 0x23456780
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	xorq	%rax, %rax
               	xorq	$-0x1, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%rax, %r10
               	movq	%r10, 0x58(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movl	$0x1f, %r12d
               	movl	%r12d, (%r14)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	%rax, %r15
               	leaq	<rip>, %r14
               	movl	$0x4f, %ebx
               	movq	%r15, %rdi
               	movq	%r12, %rcx
               	movq	%rbx, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x58(%rsp), %rax
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
               	leaq	<rip>, %rbx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %r10
               	movq	%r10, 0x50(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movl	$0x20, %ebx
               	movl	%ebx, (%r14)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	%rax, %r15
               	leaq	<rip>, %r14
               	movl	$0x54, %r12d
               	movq	%r15, %rdi
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x50(%rsp), %rbx
               	movslq	%ebx, %rbx
               	cmpq	$-0x7fffffff, %rbx      # imm = 0x80000001
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movl	$0x28, %r12d
               	movl	%r12d, (%r14)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	<rip>, %r14
               	movl	$0x5d, %r15d
               	movq	%rbx, %rdi
               	movq	%r12, %rcx
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x50(%rsp), %rax
               	movslq	%eax, %rax
               	cmpq	$-0x7fffffff, %rax      # imm = 0x80000001
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	movabsq	$-0x1, %r10
               	movq	%r10, 0x40(%rsp)
               	movl	$0x1, %r10d
               	movq	%r10, 0x48(%rsp)
               	movq	0x40(%rsp), %r15
               	movq	0x48(%rsp), %r10
               	addq	%r10, %r15
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r15, %r10
               	movq	%r10, 0x38(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movl	$0x29, %r12d
               	movl	%r12d, (%r15)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r14
               	leaq	<rip>, %r15
               	movl	$0x5e, %ebx
               	movq	%r14, %rdi
               	movq	%r12, %rcx
               	movq	%rbx, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x38(%rsp), %rbx
               	cmpq	$0x0, %rbx
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	<addr>
               	movq	0x40(%rsp), %rax
               	movq	0x48(%rsp), %r10
               	subq	%r10, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%rax, %r10
               	movq	%r10, 0x30(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x32, %ebx
               	movl	%ebx, (%rax)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	<rip>, %r14
               	movl	$0x68, %r15d
               	movq	%r12, %rdi
               	movq	%rbx, %rcx
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x30(%rsp), %rax
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
               	movl	$0x12345678, %r10d      # imm = 0x12345678
               	movq	%r10, 0x28(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movl	$0x33, %r15d
               	movl	%r15d, (%r14)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	<rip>, %r14
               	movl	$0x6c, %ebx
               	movq	%r12, %rdi
               	movq	%r15, %rcx
               	movq	%rbx, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x28(%rsp), %rbx
               	cmpq	$0x12345678, %rbx       # imm = 0x12345678
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movl	$0x3c, %r12d
               	movl	%r12d, (%r14)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	<rip>, %r14
               	movl	$0x73, %r15d
               	movq	%rbx, %rdi
               	movq	%r12, %rcx
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x28(%rsp), %rax
               	cmpq	$0x12345678, %rax       # imm = 0x12345678
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	movabsq	$-0x77359400, %r10      # imm = 0x88CA6C00
               	movq	%r10, 0x20(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movl	$0x3d, %r12d
               	movl	%r12d, (%r15)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
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
               	movq	0x20(%rsp), %rbx
               	cmpq	$-0x77359400, %rbx      # imm = 0x88CA6C00
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movl	$0x3e, %r14d
               	movl	%r14d, (%r15)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	<rip>, %r15
               	movl	$0x7a, %r12d
               	movq	%rbx, %rdi
               	movq	%r14, %rcx
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x20(%rsp), %rax
               	cmpq	$-0x77359400, %rax      # imm = 0x88CA6C00
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movl	$0x3f, %r14d
               	movl	%r14d, (%r12)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r15
               	leaq	<rip>, %r12
               	movl	$0x7b, %ebx
               	movq	%r15, %rdi
               	movq	%r14, %rcx
               	movq	%rbx, %rdx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movq	%r14, %rdi
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
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %r14
               	movslq	(%r14), %r14
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
