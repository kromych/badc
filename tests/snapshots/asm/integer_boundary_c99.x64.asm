
integer_boundary_c99.x64:	file format elf64-x86-64

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
               	subq	$0x160, %rsp            # imm = 0x160
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	jmp	<addr>
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r9
               	movl	$0x64, %ebx
               	movl	%ebx, (%r9)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %r9
               	leaq	<rip>, %rsi
               	movl	$0x36, %edx
               	movq	%r9, %rdi
               	movq	%rbx, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	jmp	<addr>
               	xorq	%r9, %r9
               	cmpq	$0x0, %r9
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movl	$0x65, %r12d
               	movl	%r12d, (%rdx)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdx
               	leaq	<rip>, %rsi
               	movl	$0x37, %r9d
               	movq	%rdx, %rdi
               	movq	%r12, %rcx
               	movq	%r9, %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r9
               	movl	$0x66, %ebx
               	movl	%ebx, (%r9)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %r9
               	leaq	<rip>, %rsi
               	movl	$0x38, %edx
               	movq	%r9, %rdi
               	movq	%rbx, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	jmp	<addr>
               	xorq	%r9, %r9
               	cmpq	$0x0, %r9
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movl	$0x67, %r12d
               	movl	%r12d, (%rdx)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdx
               	leaq	<rip>, %rsi
               	movl	$0x39, %r9d
               	movq	%rdx, %rdi
               	movq	%r12, %rcx
               	movq	%r9, %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r9
               	movl	$0x68, %ebx
               	movl	%ebx, (%r9)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %r9
               	leaq	<rip>, %rsi
               	movl	$0x3a, %edx
               	movq	%r9, %rdi
               	movq	%rbx, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	jmp	<addr>
               	xorq	%r9, %r9
               	cmpq	$0x0, %r9
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movl	$0x69, %r12d
               	movl	%r12d, (%rdx)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdx
               	leaq	<rip>, %rsi
               	movl	$0x3b, %r9d
               	movq	%rdx, %rdi
               	movq	%r12, %rcx
               	movq	%r9, %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r9
               	movl	$0x6a, %ebx
               	movl	%ebx, (%r9)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %r9
               	leaq	<rip>, %rsi
               	movl	$0x3c, %edx
               	movq	%r9, %rdi
               	movq	%rbx, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	jmp	<addr>
               	xorq	%r9, %r9
               	cmpq	$0x0, %r9
               	jne	<addr>
               	movl	$0xff, %eax
               	movb	%al, -0x8(%rbp)
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movl	$0x6b, %r12d
               	movl	%r12d, (%rdx)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdx
               	leaq	<rip>, %rsi
               	movl	$0x3d, %r9d
               	movq	%rdx, %rdi
               	movq	%r12, %rcx
               	movq	%r9, %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movzbq	-0x8(%rbp), %rax
               	xorq	$0xff, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	leaq	-0x8(%rbp), %rax
               	movzbq	(%rax), %rdx
               	addq	$0x1, %rdx
               	movb	%dl, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %r9
               	movl	$0x6e, %ebx
               	movl	%ebx, (%r9)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %r9
               	leaq	<rip>, %rsi
               	movl	$0x42, %edx
               	movq	%r9, %rdi
               	movq	%rbx, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movzbq	-0x8(%rbp), %rdx
               	cmpq	$0x0, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	leaq	-0x8(%rbp), %rax
               	movzbq	(%rax), %rdx
               	addq	$-0x1, %rdx
               	movb	%dl, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movl	$0x6f, %r12d
               	movl	%r12d, (%rsi)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rsi
               	leaq	<rip>, %rdi
               	movl	$0x44, %edx
               	movq	%r12, %rcx
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	movq	%r10, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movzbq	-0x8(%rbp), %rdx
               	xorq	$0xff, %rdx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rdx
               	cmpq	$0x0, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	movl	$0x7f, %r15d
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x70, %r14d
               	movl	%r14d, (%rdi)
               	movl	$0x2, %edi
               	callq	<addr>
               	leaq	<rip>, %rsi
               	movl	$0x46, %edx
               	movq	%rax, %rdi
               	movq	%r14, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %r12
               	jmp	<addr>
               	jmp	<addr>
               	cmpq	$0x7f, %r15
               	sete	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	movabsq	$-0x80, %rax
               	movb	%al, -0x18(%rbp)
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movl	$0x71, %r12d
               	movl	%r12d, (%rsi)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rsi
               	leaq	<rip>, %rdi
               	movl	$0x49, %edx
               	movq	%r12, %rcx
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	movq	%r10, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movsbq	-0x18(%rbp), %rax
               	cmpq	$-0x80, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	<addr>
               	leaq	-0x18(%rbp), %rax
               	movsbq	(%rax), %r15
               	addq	$-0x1, %r15
               	movb	%r15b, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movl	$0x72, %r14d
               	movl	%r14d, (%rdx)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdx
               	leaq	<rip>, %rsi
               	movl	$0x4b, %r15d
               	movq	%rdx, %rdi
               	movq	%r14, %rcx
               	movq	%r15, %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movsbq	-0x18(%rbp), %r15
               	andq	$0xff, %r15
               	xorq	$0x7f, %r15
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r15
               	cmpq	$0x0, %r15
               	sete	%r15b
               	movzbq	%r15b, %r15
               	cmpq	$0x0, %r15
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	movl	$0xffff, %eax           # imm = 0xFFFF
               	movw	%ax, -0x20(%rbp)
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movl	$0x73, %ebx
               	movl	%ebx, (%rsi)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rsi
               	leaq	<rip>, %rdi
               	movl	$0x4d, %edx
               	movq	%rbx, %rcx
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	movq	%r10, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movzwq	-0x20(%rbp), %rax
               	xorq	$0xffff, %rax           # imm = 0xFFFF
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rdi, %rdi
               	cmpq	$0x0, %rdi
               	jne	<addr>
               	leaq	-0x20(%rbp), %rax
               	movzwq	(%rax), %rdi
               	addq	$0x1, %rdi
               	movw	%di, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movl	$0x78, %r14d
               	movl	%r14d, (%rdx)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdx
               	leaq	<rip>, %rsi
               	movl	$0x53, %edi
               	movq	%r14, %rcx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	movq	%r10, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movzwq	-0x20(%rbp), %rdi
               	cmpq	$0x0, %rdi
               	sete	%dil
               	movzbq	%dil, %rdi
               	cmpq	$0x0, %rdi
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	xorq	%rax, %rax
               	movw	%ax, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rdx
               	movzwq	(%rdx), %rax
               	addq	$-0x1, %rax
               	movw	%ax, (%rdx)
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movl	$0x79, %ebx
               	movl	%ebx, (%rsi)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rsi
               	leaq	<rip>, %rdi
               	movl	$0x55, %edx
               	movq	%rbx, %rcx
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	movq	%r10, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movzwq	-0x20(%rbp), %rax
               	xorq	$0xffff, %rax           # imm = 0xFFFF
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rdi, %rdi
               	cmpq	$0x0, %rdi
               	jne	<addr>
               	movl	$0x7fff, %ebx           # imm = 0x7FFF
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x7a, %r14d
               	movl	%r14d, (%rdi)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdx
               	leaq	<rip>, %rsi
               	movl	$0x58, %edi
               	movq	%r14, %rcx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	movq	%r10, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	cmpq	$0x7fff, %rbx           # imm = 0x7FFF
               	sete	%dil
               	movzbq	%dil, %rdi
               	cmpq	$0x0, %rdi
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	movabsq	$-0x8000, %r12          # imm = 0x8000
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movl	$0x7b, %r15d
               	movl	%r15d, (%rsi)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rsi
               	leaq	<rip>, %rdi
               	movl	$0x5b, %edx
               	movq	%r15, %rcx
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	movq	%r10, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	cmpq	$-0x8000, %r12          # imm = 0x8000
               	sete	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	andq	$0xffff, %r12           # imm = 0xFFFF
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	movl	$0x7c, %r14d
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
               	movq	%r12, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	xorq	$0x8000, %rax           # imm = 0x8000
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
               	movl	$0x12345, %eax          # imm = 0x12345
               	movswq	%ax, %r14
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movl	$0x7d, %r15d
               	movl	%r15d, (%rdx)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdx
               	leaq	<rip>, %rsi
               	movl	$0x5f, %ebx
               	movq	%rdx, %rdi
               	movq	%r15, %rcx
               	movq	%rbx, %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movswq	%r14w, %rax
               	cmpq	$0x2345, %rax           # imm = 0x2345
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	movabsq	$-0x2a, %r15
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movl	$0x7e, %ebx
               	movl	%ebx, (%r12)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	<rip>, %rsi
               	movl	$0x64, %edx
               	movq	%r12, %rdi
               	movq	%rbx, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%r15d, %rdx
               	cmpq	$-0x2a, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	movl	$0xffff, %r12d          # imm = 0xFFFF
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movl	$0x7f, %ebx
               	movl	%ebx, (%r14)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %r14
               	leaq	<rip>, %rsi
               	movl	$0x69, %edx
               	movq	%r14, %rdi
               	movq	%rbx, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0xffffffff, %edx       # imm = 0xFFFFFFFF
               	andq	%r12, %rdx
               	xorq	$0xffff, %rdx           # imm = 0xFFFF
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rdx
               	cmpq	$0x0, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movl	$0x80, %ebx
               	movl	%ebx, (%r15)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %r15
               	leaq	<rip>, %rsi
               	movl	$0x6e, %edx
               	movq	%r15, %rdi
               	movq	%rbx, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	cmpq	$0xffff, %r12           # imm = 0xFFFF
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	<addr>
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	movl	%eax, -0x70(%rbp)
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movl	$0x81, %r14d
               	movl	%r14d, (%rdx)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdx
               	leaq	<rip>, %rsi
               	movl	$0x70, %r15d
               	movq	%rdx, %rdi
               	movq	%r14, %rcx
               	movq	%r15, %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movl	-0x70(%rbp), %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	leaq	-0x70(%rbp), %rax
               	movl	(%rax), %edx
               	addq	$0x1, %rdx
               	movl	%edx, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movl	$0x82, %ebx
               	movl	%ebx, (%r15)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %r15
               	leaq	<rip>, %rsi
               	movl	$0x76, %edx
               	movq	%r15, %rdi
               	movq	%rbx, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movl	-0x70(%rbp), %edx
               	cmpq	$0x0, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	xorq	%rax, %rax
               	movl	%eax, -0x70(%rbp)
               	leaq	-0x70(%rbp), %rdx
               	movl	(%rdx), %eax
               	addq	$-0x1, %rax
               	movl	%eax, (%rdx)
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movl	$0x83, %r12d
               	movl	%r12d, (%rsi)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rsi
               	leaq	<rip>, %rdi
               	movl	$0x78, %edx
               	movq	%r12, %rcx
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	movq	%r10, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movl	-0x70(%rbp), %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rdi, %rdi
               	cmpq	$0x0, %rdi
               	jne	<addr>
               	movl	$0x7fffffff, %r12d      # imm = 0x7FFFFFFF
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x84, %ebx
               	movl	%ebx, (%rdi)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdx
               	leaq	<rip>, %rsi
               	movl	$0x7b, %edi
               	movq	%rbx, %rcx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	movq	%r10, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	cmpq	$0x7fffffff, %r12       # imm = 0x7FFFFFFF
               	sete	%dil
               	movzbq	%dil, %rdi
               	cmpq	$0x0, %rdi
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	movabsq	$-0x80000000, %r14      # imm = 0x80000000
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movl	$0x85, %r15d
               	movl	%r15d, (%rsi)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rsi
               	leaq	<rip>, %rdi
               	movl	$0x7e, %edx
               	movq	%r15, %rcx
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	movq	%r10, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	cmpq	$-0x80000000, %r14      # imm = 0x80000000
               	sete	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movl	$0x86, %ebx
               	movl	%ebx, (%r12)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	<rip>, %rsi
               	movl	$0x80, %edx
               	movq	%r12, %rdi
               	movq	%rbx, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	cmpq	$-0x80000000, %r14      # imm = 0x80000000
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r14
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movl	$0x87, %r15d
               	movl	%r15d, (%rdx)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdx
               	leaq	<rip>, %rsi
               	movl	$0x86, %r12d
               	movq	%rdx, %rdi
               	movq	%r15, %rcx
               	movq	%r12, %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x80000000, %r11d      # imm = 0x80000000
               	movq	%r14, %rax
               	cmpq	%r11, %r14
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rsi, %rsi
               	cmpq	$0x0, %rsi
               	jne	<addr>
               	movabsq	$-0x1, %rax
               	movq	%rax, -0x98(%rbp)
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movl	$0x88, %ebx
               	movl	%ebx, (%r12)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	<rip>, %rsi
               	movq	%r12, %rdi
               	movq	%rbx, %rcx
               	movq	%rbx, %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x98(%rbp), %rax
               	cmpq	$-0x1, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	leaq	-0x98(%rbp), %rax
               	movq	(%rax), %rdx
               	addq	$0x1, %rdx
               	movq	%rdx, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movl	$0x8c, %r15d
               	movl	%r15d, (%rsi)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rsi
               	leaq	<rip>, %rdi
               	movl	$0x8e, %edx
               	movq	%r15, %rcx
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	movq	%r10, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x98(%rbp), %rdx
               	cmpq	$0x0, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	leaq	-0x98(%rbp), %r15
               	movq	(%r15), %rdx
               	addq	$-0x1, %rdx
               	movq	%rdx, (%r15)
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x8d, %r12d
               	movl	%r12d, (%rdi)
               	movl	$0x2, %edi
               	callq	<addr>
               	leaq	<rip>, %rsi
               	movl	$0x90, %edx
               	movq	%rax, %rdi
               	movq	%r12, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %r15
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x98(%rbp), %rdx
               	cmpq	$-0x1, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	movabsq	$0x7fffffffffffffff, %r15 # imm = 0x7FFFFFFFFFFFFFFF
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movl	$0x8e, %r14d
               	movl	%r14d, (%rsi)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rsi
               	leaq	<rip>, %rdi
               	movl	$0x92, %edx
               	movq	%r14, %rcx
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	movq	%r10, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movabsq	$0x7fffffffffffffff, %r11 # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%r15, %rdx
               	cmpq	%r11, %r15
               	sete	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	movabsq	$-0x1, %rbx
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x8f, %r12d
               	movl	%r12d, (%rdi)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rsi
               	leaq	<rip>, %rdi
               	movl	$0x95, %edx
               	movq	%r12, %rcx
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	movq	%r10, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rbx, %rdx
               	sarq	$0x1, %rdx
               	cmpq	$-0x1, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	movabsq	$-0x8000000000000000, %r12 # imm = 0x8000000000000000
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movl	$0x90, %r14d
               	movl	%r14d, (%r15)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %r15
               	leaq	<rip>, %rsi
               	movl	$0x9a, %edx
               	movq	%r15, %rdi
               	movq	%r14, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	%r12, %rdx
               	shrq	$0x1, %rdx
               	movabsq	$0x4000000000000000, %r11 # imm = 0x4000000000000000
               	cmpq	%r11, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	movabsq	$-0x1, %r15
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	movl	$0x91, %r14d
               	movl	%r14d, (%rbx)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	<rip>, %rsi
               	movl	$0x9d, %edx
               	movq	%rbx, %rdi
               	movq	%r14, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	%r15, %rdx
               	shrq	$0x20, %rdx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	movabsq	$-0x12c, %rbx           # imm = 0xFED4
               	movsbq	%bl, %r14
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movl	$0x92, %r14d
               	movl	%r14d, (%r12)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	<rip>, %rsi
               	movl	$0xa0, %edx
               	movq	%r12, %rdi
               	movq	%r14, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movsbq	%r14b, %rdx
               	cmpq	$-0x2c, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movl	$0x96, %r15d
               	movl	%r15d, (%rsi)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rsi
               	leaq	<rip>, %rdi
               	movl	$0xa9, %edx
               	movq	%r15, %rcx
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	movq	%r10, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movsbq	%r14b, %rax
               	cmpq	$-0x2c, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rdi, %rdi
               	cmpq	$0x0, %rdi
               	jne	<addr>
               	andq	$0xff, %rbx
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movl	$0x97, %r12d
               	movl	%r12d, (%rdx)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdx
               	leaq	<rip>, %rsi
               	movl	$0xaa, %edi
               	movq	%r12, %rcx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	movq	%r10, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rbx, %rax
               	andq	$0xff, %rax
               	xorq	$0xd4, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
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
               	leaq	<rip>, %rdi
               	movl	$0x98, %r15d
               	movl	%r15d, (%rdi)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %r14
               	leaq	<rip>, %rsi
               	movl	$0xaf, %edx
               	movq	%r14, %rdi
               	movq	%r15, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rbx, %rax
               	andq	$0xff, %rax
               	cmpq	$0xd4, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	movl	$0x12345, %eax          # imm = 0x12345
               	movswq	%ax, %r15
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movl	$0x99, %r12d
               	movl	%r12d, (%rdx)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdx
               	leaq	<rip>, %rsi
               	movl	$0xb0, %r14d
               	movq	%rdx, %rdi
               	movq	%r12, %rcx
               	movq	%r14, %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movswq	%r15w, %rax
               	cmpq	$0x2345, %rax           # imm = 0x2345
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	movl	$0x9a, %r14d
               	movl	%r14d, (%rbx)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	<rip>, %rsi
               	movl	$0xb5, %edx
               	movq	%rbx, %rdi
               	movq	%r14, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movswq	%r15w, %rax
               	cmpq	$0x2345, %rax           # imm = 0x2345
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	movl	$0x1ffff, %eax          # imm = 0x1FFFF
               	movswq	%ax, %r14
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movl	$0x9b, %r12d
               	movl	%r12d, (%rdx)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdx
               	leaq	<rip>, %rsi
               	movl	$0xb6, %ebx
               	movq	%rdx, %rdi
               	movq	%r12, %rcx
               	movq	%rbx, %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movswq	%r14w, %rax
               	cmpq	$-0x1, %rax
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
               	movl	$0x9c, %ebx
               	movl	%ebx, (%r15)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %r15
               	leaq	<rip>, %rsi
               	movl	$0xba, %edx
               	movq	%r15, %rdi
               	movq	%rbx, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movswq	%r14w, %rax
               	cmpq	$-0x1, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	<addr>
               	movl	$0xffffffff, %ebx       # imm = 0xFFFFFFFF
               	movl	$0x1, %r12d
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movl	$0x9d, %r12d
               	movl	%r12d, (%rdx)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdx
               	leaq	<rip>, %rsi
               	movl	$0xbb, %r15d
               	movq	%rdx, %rdi
               	movq	%r12, %rcx
               	movq	%r15, %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	cmpq	%r12, %rbx
               	seta	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	movslq	%ebx, %rbx
               	movslq	%r12d, %r12
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movl	$0xa0, %r15d
               	movl	%r15d, (%rsi)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rsi
               	leaq	<rip>, %rdi
               	movl	$0xc2, %edx
               	movq	%r15, %rcx
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	movq	%r10, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%ebx, %rax
               	movslq	%r12d, %rdx
               	cmpq	%rdx, %rax
               	setl	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rdi, %rdi
               	cmpq	$0x0, %rdi
               	jne	<addr>
               	movl	$0x1, %r15d
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movl	$0xa1, %r14d
               	movl	%r14d, (%rdx)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdx
               	leaq	<rip>, %rsi
               	movl	$0xc5, %edi
               	movq	%r14, %rcx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	movq	%r10, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	%r15, %rdi
               	shlq	$0x1e, %rdi
               	cmpq	$0x40000000, %rdi       # imm = 0x40000000
               	sete	%dil
               	movzbq	%dil, %rdi
               	cmpq	$0x0, %rdi
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	movl	$0x1, %ebx
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movl	$0xaa, %r14d
               	movl	%r14d, (%r12)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	<rip>, %rsi
               	movl	$0xcd, %edx
               	movq	%r12, %rdi
               	movq	%r14, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rbx, %rdx
               	shlq	$0x1f, %rdx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rdx
               	movl	$0x80000000, %r11d      # imm = 0x80000000
               	cmpq	%r11, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	movabsq	$-0x1, %r12
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movl	$0xab, %r14d
               	movl	%r14d, (%r15)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %r15
               	leaq	<rip>, %rsi
               	movl	$0xcf, %edx
               	movq	%r15, %rdi
               	movq	%r14, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	cmpq	$-0x1, %r12
               	sete	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	movl	$0xac, %r14d
               	movl	%r14d, (%rbx)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	<rip>, %rsi
               	movl	$0xd3, %edx
               	movq	%rbx, %rdi
               	movq	%r14, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	movq	%r15, %rdx
               	cmpq	%r11, %r15
               	sete	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movl	$0xad, %r14d
               	movl	%r14d, (%r12)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	<rip>, %rsi
               	movl	$0xd5, %edx
               	movq	%r12, %rdi
               	movq	%r14, %rcx
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
               	addq	$0x160, %rsp            # imm = 0x160
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
               	addq	$0x160, %rsp            # imm = 0x160
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
