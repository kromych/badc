
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
               	leaq	<rip>, %r8
               	movq	%rbx, %rdi
               	shlq	$0x3, %rdi
               	addq	%rdi, %r8
               	movq	(%rax), %rax
               	movq	%rax, (%r8)
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
               	subq	$0x120, %rsp            # imm = 0x120
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movabsq	$-0x1, %rbx
               	jmp	<addr>
               	cmpq	$-0x1, %rbx
               	sete	%r9b
               	movzbq	%r9b, %r9
               	cmpq	$0x0, %r9
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r8
               	movl	$0x1, %r12d
               	movl	%r12d, (%r8)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %r8
               	leaq	<rip>, %rsi
               	movl	$0x1b, %edx
               	movq	%r8, %rdi
               	movq	%r12, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	cmpq	$-0x1, %rbx
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	movl	$0xffffffff, %r12d      # imm = 0xFFFFFFFF
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movl	$0x2, %r14d
               	movl	%r14d, (%rdx)
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x1c, %edx
               	movq	%r14, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	movq	%r12, %rdx
               	cmpq	%r11, %r12
               	sete	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	movl	$0x3, %r15d
               	movl	%r15d, (%rbx)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	<rip>, %rsi
               	movl	$0x20, %edx
               	movq	%rbx, %rdi
               	movq	%r15, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	movq	%r12, %rax
               	cmpq	%r11, %r12
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	movabsq	$-0x7, %r15
               	movl	$0xffffffff, %r14d      # imm = 0xFFFFFFFF
               	andq	%r15, %r14
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movl	$0x4, %r14d
               	movl	%r14d, (%rdx)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdx
               	leaq	<rip>, %rsi
               	movl	$0x21, %ebx
               	movq	%rdx, %rdi
               	movq	%r14, %rcx
               	movq	%rbx, %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0xffffffff, %r12d      # imm = 0xFFFFFFFF
               	andq	%r14, %r12
               	movl	$0xfffffff9, %r11d      # imm = 0xFFFFFFF9
               	cmpq	%r11, %r12
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r14
               	movslq	%r14d, %r14
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movl	$0xa, %ebx
               	movl	%ebx, (%rsi)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rsi
               	leaq	<rip>, %rdi
               	movl	$0x28, %edx
               	movq	%rbx, %rcx
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	movq	%r10, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%r14d, %rdx
               	cmpq	$-0x7, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r15
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0xb, %r12d
               	movl	%r12d, (%rax)
               	movl	$0x2, %edi
               	callq	<addr>
               	leaq	<rip>, %rsi
               	movl	$0x2a, %edx
               	movq	%rax, %rdi
               	movq	%r12, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rbx
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0xfffffff9, %r11d      # imm = 0xFFFFFFF9
               	movq	%r15, %rbx
               	cmpq	%r11, %r15
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rdi, %rdi
               	cmpq	$0x0, %rdi
               	jne	<addr>
               	movl	$0xf4240, %eax          # imm = 0xF4240
               	movl	$0xbb8, %edi            # imm = 0xBB8
               	imulq	%rdi, %rax
               	movslq	%eax, %r14
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movl	$0xc, %r12d
               	movl	%r12d, (%rdx)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdx
               	leaq	<rip>, %rsi
               	movl	$0x30, %edi
               	movq	%r12, %rcx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	movq	%r10, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%r14d, %rax
               	cmpq	$-0x4d2fa200, %rax      # imm = 0xB2D05E00
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movl	$0x14, %ebx
               	movl	%ebx, (%r15)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %r15
               	leaq	<rip>, %rsi
               	movl	$0x3a, %edx
               	movq	%r15, %rdi
               	movq	%rbx, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%r14d, %rax
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
               	imulq	%rax, %rax
               	movl	$0xffffffff, %ebx       # imm = 0xFFFFFFFF
               	andq	%rax, %rbx
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movl	$0x15, %r12d
               	movl	%r12d, (%rdx)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdx
               	leaq	<rip>, %rsi
               	movl	$0x3b, %r15d
               	movq	%rdx, %rdi
               	movq	%r12, %rcx
               	movq	%r15, %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%rbx, %rax
               	cmpq	$0x0, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movl	$0x16, %r15d
               	movl	%r15d, (%r14)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %r14
               	leaq	<rip>, %rsi
               	movl	$0x40, %edx
               	movq	%r14, %rdi
               	movq	%r15, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%rbx, %rax
               	cmpq	$0x0, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	movl	$0x80000000, %eax       # imm = 0x80000000
               	movq	%rax, %r15
               	shrq	$0x1, %r15
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movl	$0x17, %r12d
               	movl	%r12d, (%rdx)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdx
               	leaq	<rip>, %rsi
               	movl	$0x41, %r14d
               	movq	%rdx, %rdi
               	movq	%r12, %rcx
               	movq	%r14, %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	cmpq	$0x40000000, %r15       # imm = 0x40000000
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	movl	$0x12345678, %eax       # imm = 0x12345678
               	shlq	$0x4, %rax
               	movl	$0xffffffff, %r12d      # imm = 0xFFFFFFFF
               	andq	%rax, %r12
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	movl	$0x1e, %r14d
               	movl	%r14d, (%rbx)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	<rip>, %rsi
               	movl	$0x4a, %edx
               	movq	%rbx, %rdi
               	movq	%r14, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	cmpq	$0x23456780, %r12       # imm = 0x23456780
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	xorq	%rax, %rax
               	xorq	$-0x1, %rax
               	movl	$0xffffffff, %ebx       # imm = 0xFFFFFFFF
               	andq	%rax, %rbx
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movl	$0x1f, %r14d
               	movl	%r14d, (%r15)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %r15
               	leaq	<rip>, %rsi
               	movl	$0x4f, %edx
               	movq	%r15, %rdi
               	movq	%r14, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	movq	%rbx, %rax
               	cmpq	%r11, %rbx
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	leaq	<rip>, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %r15
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movl	$0x20, %r14d
               	movl	%r14d, (%r12)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	<rip>, %rsi
               	movl	$0x54, %edx
               	movq	%r12, %rdi
               	movq	%r14, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%r15d, %rdi
               	cmpq	$-0x7fffffff, %rdi      # imm = 0x80000001
               	sete	%dil
               	movzbq	%dil, %rdi
               	cmpq	$0x0, %rdi
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	movl	$0x28, %r14d
               	movl	%r14d, (%rbx)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	<rip>, %rsi
               	movl	$0x5d, %edx
               	movq	%rbx, %rdi
               	movq	%r14, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%r15d, %rax
               	cmpq	$-0x7fffffff, %rax      # imm = 0x80000001
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	movabsq	$-0x1, %r14
               	movl	$0x1, %r12d
               	movq	%r14, %r15
               	addq	%r12, %r15
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r15
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movl	$0x29, %r12d
               	movl	%r12d, (%rdx)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdx
               	leaq	<rip>, %rsi
               	movl	$0x5e, %ebx
               	movq	%rdx, %rdi
               	movq	%r12, %rcx
               	movq	%rbx, %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	cmpq	$0x0, %r15
               	sete	%sil
               	movzbq	%sil, %rsi
               	cmpq	$0x0, %rsi
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	subq	%r12, %r14
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r14
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movl	$0x32, %ebx
               	movl	%ebx, (%rdx)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdx
               	leaq	<rip>, %rsi
               	movl	$0x68, %eax
               	movq	%rdx, %rdi
               	movq	%rbx, %rcx
               	movq	%rax, %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %r8
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0xfffffffe, %r11d      # imm = 0xFFFFFFFE
               	movq	%r14, %r12
               	cmpq	%r11, %r14
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	movl	$0x12345678, %r12d      # imm = 0x12345678
               	jmp	<addr>
               	leaq	<rip>, %r8
               	movl	$0x33, %ebx
               	movl	%ebx, (%r8)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %r8
               	leaq	<rip>, %rsi
               	movl	$0x6c, %edx
               	movq	%r8, %rdi
               	movq	%rbx, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	cmpq	$0x12345678, %r12       # imm = 0x12345678
               	sete	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movl	$0x3c, %r15d
               	movl	%r15d, (%r14)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %r14
               	leaq	<rip>, %rsi
               	movl	$0x73, %edx
               	movq	%r14, %rdi
               	movq	%r15, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	cmpq	$0x12345678, %r12       # imm = 0x12345678
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	movabsq	$-0x77359400, %r15      # imm = 0x88CA6C00
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movl	$0x3d, %ebx
               	movl	%ebx, (%rdx)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdx
               	leaq	<rip>, %rsi
               	movl	$0x75, %r14d
               	movq	%rdx, %rdi
               	movq	%rbx, %rcx
               	movq	%r14, %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	cmpq	$-0x77359400, %r15      # imm = 0x88CA6C00
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movl	$0x3e, %ebx
               	movl	%ebx, (%r12)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	<rip>, %rsi
               	movl	$0x7a, %edx
               	movq	%r12, %rdi
               	movq	%rbx, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	cmpq	$-0x77359400, %r15      # imm = 0x88CA6C00
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movl	$0x3f, %r14d
               	movl	%r14d, (%rdx)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdx
               	leaq	<rip>, %rsi
               	movl	$0x7b, %r12d
               	movq	%rdx, %rdi
               	movq	%r14, %rcx
               	movq	%r12, %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
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
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movslq	(%rdi), %rdi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
