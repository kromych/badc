
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
               	jmp	<addr>
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
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0xffffffff, %ebx       # imm = 0xFFFFFFFF
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x2, %r14d
               	movl	%r14d, (%rax)
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
               	movq	%rbx, %rdx
               	cmpq	%r11, %rbx
               	sete	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movl	$0x3, %r15d
               	movl	%r15d, (%rsi)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rsi
               	leaq	<rip>, %rdi
               	movl	$0x20, %edx
               	movq	%r15, %rcx
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	movq	%r10, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rbx
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movabsq	$-0x7, %rbx
               	movl	$0xffffffff, %r14d      # imm = 0xFFFFFFFF
               	andq	%rbx, %r14
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x4, %r12d
               	movl	%r12d, (%rax)
               	movl	$0x2, %edi
               	callq	<addr>
               	leaq	<rip>, %rsi
               	movl	$0x21, %edx
               	movq	%rax, %rdi
               	movq	%r12, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rdi
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0xffffffff, %esi       # imm = 0xFFFFFFFF
               	andq	%r14, %rsi
               	movl	$0xfffffff9, %r11d      # imm = 0xFFFFFFF9
               	cmpq	%r11, %rsi
               	sete	%sil
               	movzbq	%sil, %rsi
               	cmpq	$0x0, %rsi
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r14
               	movslq	%r14d, %r14
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0xa, %r15d
               	movl	%r15d, (%rax)
               	movl	$0x2, %edi
               	callq	<addr>
               	leaq	<rip>, %rsi
               	movl	$0x28, %edx
               	movq	%rax, %rdi
               	movq	%r15, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%r14d, %r14
               	cmpq	$-0x7, %r14
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rbx
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movl	$0xb, %r12d
               	movl	%r12d, (%rdx)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdx
               	leaq	<rip>, %rsi
               	movl	$0x2a, %edi
               	movq	%r12, %rcx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	movq	%r10, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0xfffffff9, %r11d      # imm = 0xFFFFFFF9
               	cmpq	%r11, %rbx
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0xf4240, %edi          # imm = 0xF4240
               	movl	$0xbb8, %edx            # imm = 0xBB8
               	imulq	%rdx, %rdi
               	movslq	%edi, %rbx
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0xc, %r14d
               	movl	%r14d, (%rax)
               	movl	$0x2, %edi
               	callq	<addr>
               	leaq	<rip>, %rsi
               	movl	$0x30, %edx
               	movq	%rax, %rdi
               	movq	%r14, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rdi
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%ebx, %rdi
               	cmpq	$-0x4d2fa200, %rdi      # imm = 0xB2D05E00
               	sete	%dil
               	movzbq	%dil, %rdi
               	cmpq	$0x0, %rdi
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movl	$0x14, %r15d
               	movl	%r15d, (%rsi)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rsi
               	leaq	<rip>, %rdi
               	movl	$0x3a, %edx
               	movq	%r15, %rcx
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	movq	%r10, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%ebx, %rbx
               	cmpq	$-0x4d2fa200, %rbx      # imm = 0xB2D05E00
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x10000, %edi          # imm = 0x10000
               	imulq	%rdi, %rdi
               	movl	$0xffffffff, %ebx       # imm = 0xFFFFFFFF
               	andq	%rdi, %rbx
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movl	$0x15, %r14d
               	movl	%r14d, (%rdx)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdx
               	leaq	<rip>, %rsi
               	movl	$0x3b, %eax
               	movq	%rdx, %rdi
               	movq	%r14, %rcx
               	movq	%rax, %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rdi
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	andq	%rbx, %rdi
               	cmpq	$0x0, %rdi
               	sete	%dil
               	movzbq	%dil, %rdi
               	cmpq	$0x0, %rdi
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movl	$0x16, %r12d
               	movl	%r12d, (%rsi)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rsi
               	leaq	<rip>, %rdi
               	movl	$0x40, %edx
               	movq	%r12, %rcx
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	movq	%r10, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rbx
               	cmpq	$0x0, %rbx
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x80000000, %edi       # imm = 0x80000000
               	shrq	$0x1, %rdi
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movl	$0x17, %r15d
               	movl	%r15d, (%rdx)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdx
               	leaq	<rip>, %rsi
               	movl	$0x41, %eax
               	movq	%rdx, %rdi
               	movq	%r15, %rcx
               	movq	%rax, %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rdi
               	jmp	<addr>
               	jmp	<addr>
               	cmpq	$0x40000000, %rdi       # imm = 0x40000000
               	sete	%dil
               	movzbq	%dil, %rdi
               	cmpq	$0x0, %rdi
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x12345678, %r15d      # imm = 0x12345678
               	shlq	$0x4, %r15
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r15
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x1e, %ebx
               	movl	%ebx, (%rax)
               	movl	$0x2, %edi
               	callq	<addr>
               	leaq	<rip>, %rsi
               	movl	$0x4a, %edx
               	movq	%rax, %rdi
               	movq	%rbx, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %r15
               	jmp	<addr>
               	jmp	<addr>
               	cmpq	$0x23456780, %r15       # imm = 0x23456780
               	sete	%r15b
               	movzbq	%r15b, %r15
               	cmpq	$0x0, %r15
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rbx, %rbx
               	xorq	$-0x1, %rbx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rbx
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movl	$0x1f, %r14d
               	movl	%r14d, (%rdx)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdx
               	leaq	<rip>, %rsi
               	movl	$0x4f, %eax
               	movq	%rdx, %rdi
               	movq	%r14, %rcx
               	movq	%rax, %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rbx
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rbx
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %r14
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x20, %r15d
               	movl	%r15d, (%rax)
               	movl	$0x2, %edi
               	callq	<addr>
               	leaq	<rip>, %rsi
               	movl	$0x54, %edx
               	movq	%rax, %rdi
               	movq	%r15, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %r14
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%r14d, %rdi
               	cmpq	$-0x7fffffff, %rdi      # imm = 0x80000001
               	sete	%dil
               	movzbq	%dil, %rdi
               	cmpq	$0x0, %rdi
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movl	$0x28, %ebx
               	movl	%ebx, (%rsi)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rsi
               	leaq	<rip>, %rdi
               	movl	$0x5d, %edx
               	movq	%rbx, %rcx
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	movq	%r10, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%r14d, %r14
               	cmpq	$-0x7fffffff, %r14      # imm = 0x80000001
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movabsq	$-0x1, %r14
               	movl	$0x1, %r12d
               	movq	%r14, %rsi
               	addq	%r12, %rsi
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rsi
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movl	$0x29, %r15d
               	movl	%r15d, (%rdx)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdx
               	leaq	<rip>, %rsi
               	movl	$0x5e, %eax
               	movq	%rdx, %rdi
               	movq	%r15, %rcx
               	movq	%rax, %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rdi
               	jmp	<addr>
               	jmp	<addr>
               	cmpq	$0x0, %rsi
               	sete	%sil
               	movzbq	%sil, %rsi
               	cmpq	$0x0, %rsi
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
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
               	movl	$0x68, %edi
               	movq	%rbx, %rcx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	movq	%r10, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0xfffffffe, %r11d      # imm = 0xFFFFFFFE
               	cmpq	%r11, %r14
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x12345678, %r14d      # imm = 0x12345678
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movl	$0x33, %r15d
               	movl	%r15d, (%r12)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	<rip>, %rsi
               	movl	$0x6c, %edx
               	movq	%r12, %rdi
               	movq	%r15, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	cmpq	$0x12345678, %r14       # imm = 0x12345678
               	sete	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movl	$0x3c, %ebx
               	movl	%ebx, (%rsi)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rsi
               	leaq	<rip>, %rdi
               	movl	$0x73, %edx
               	movq	%rbx, %rcx
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	movq	%r10, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	cmpq	$0x12345678, %r14       # imm = 0x12345678
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movabsq	$-0x77359400, %r14      # imm = 0x88CA6C00
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x3d, %r12d
               	movl	%r12d, (%rax)
               	movl	$0x2, %edi
               	callq	<addr>
               	leaq	<rip>, %rsi
               	movl	$0x75, %edx
               	movq	%rax, %rdi
               	movq	%r12, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rdi
               	jmp	<addr>
               	jmp	<addr>
               	cmpq	$-0x77359400, %r14      # imm = 0x88CA6C00
               	sete	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movl	$0x3e, %r15d
               	movl	%r15d, (%rsi)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rsi
               	leaq	<rip>, %rdi
               	movl	$0x7a, %edx
               	movq	%r15, %rcx
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	movq	%r10, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	cmpq	$-0x77359400, %r14      # imm = 0x88CA6C00
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movslq	(%rdi), %rdi
               	cmpq	$0x0, %rdi
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x3f, %ebx
               	movl	%ebx, (%rax)
               	movl	$0x2, %edi
               	callq	<addr>
               	leaq	<rip>, %rsi
               	movl	$0x7b, %edx
               	movq	%rax, %rdi
               	movq	%rbx, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rdi
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movq	%rdx, %rdi
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
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rdx
               	movq	%rdx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
