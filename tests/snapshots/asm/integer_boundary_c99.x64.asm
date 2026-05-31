
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
               	subq	$0x240, %rsp            # imm = 0x240
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	jmp	<addr>
               	movl	$0x1, %r11d
               	cmpq	$0x0, %r11
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r9
               	movl	$0x64, %ebx
               	movl	%ebx, (%r9)
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, %r14
               	leaq	<rip>, %r15
               	movl	$0x36, %r12d
               	movq	%r14, %rdi
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x1, %eax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movl	$0x65, %ebx
               	movl	%ebx, (%r12)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	%rax, %r15
               	leaq	<rip>, %r12
               	movl	$0x37, %r14d
               	movq	%r15, %rdi
               	movq	%rbx, %rcx
               	movq	%r14, %rdx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x1, %eax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movl	$0x66, %ebx
               	movl	%ebx, (%r14)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	<rip>, %r14
               	movl	$0x38, %r15d
               	movq	%r12, %rdi
               	movq	%rbx, %rcx
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x1, %eax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movl	$0x67, %ebx
               	movl	%ebx, (%r15)
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, %r14
               	leaq	<rip>, %r15
               	movl	$0x39, %r12d
               	movq	%r14, %rdi
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x1, %eax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movl	$0x68, %ebx
               	movl	%ebx, (%r12)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	%rax, %r15
               	leaq	<rip>, %r12
               	movl	$0x3a, %r14d
               	movq	%r15, %rdi
               	movq	%rbx, %rcx
               	movq	%r14, %rdx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x1, %eax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movl	$0x69, %ebx
               	movl	%ebx, (%r14)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	<rip>, %r14
               	movl	$0x3b, %r15d
               	movq	%r12, %rdi
               	movq	%rbx, %rcx
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x1, %eax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movl	$0x6a, %ebx
               	movl	%ebx, (%r15)
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, %r14
               	leaq	<rip>, %r15
               	movl	$0x3c, %r12d
               	movq	%r14, %rdi
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x1, %eax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	movl	$0xff, %eax
               	movb	%al, -0x8(%rbp)
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movl	$0x6b, %ebx
               	movl	%ebx, (%r12)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	%rax, %r15
               	leaq	<rip>, %r12
               	movl	$0x3d, %r14d
               	movq	%r15, %rdi
               	movq	%rbx, %rcx
               	movq	%r14, %rdx
               	movq	%r12, %rsi
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
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	<addr>
               	leaq	-0x8(%rbp), %rax
               	movzbq	(%rax), %r15
               	addq	$0x1, %r15
               	movb	%r15b, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movl	$0x6e, %ebx
               	movl	%ebx, (%r14)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	<rip>, %r14
               	movl	$0x42, %r15d
               	movq	%r12, %rdi
               	movq	%rbx, %rcx
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movzbq	-0x8(%rbp), %r15
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r15
               	cmpq	$0x0, %r15
               	sete	%r15b
               	movzbq	%r15b, %r15
               	cmpq	$0x0, %r15
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	<addr>
               	leaq	-0x8(%rbp), %rax
               	movzbq	(%rax), %r15
               	addq	$-0x1, %r15
               	movb	%r15b, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movl	$0x6f, %ebx
               	movl	%ebx, (%r14)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	<rip>, %r14
               	movl	$0x44, %r15d
               	movq	%r12, %rdi
               	movq	%rbx, %rcx
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movzbq	-0x8(%rbp), %r15
               	xorq	$0xff, %r15
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r15
               	cmpq	$0x0, %r15
               	sete	%r15b
               	movzbq	%r15b, %r15
               	cmpq	$0x0, %r15
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	<addr>
               	movl	$0x7f, %r10d
               	movq	%r10, 0xf8(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movl	$0x70, %ebx
               	movl	%ebx, (%r14)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	<rip>, %r14
               	movl	$0x46, %r15d
               	movq	%r12, %rdi
               	movq	%rbx, %rcx
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0xf8(%rsp), %r15
               	movsbq	%r15b, %r15
               	cmpq	$0x7f, %r15
               	sete	%r15b
               	movzbq	%r15b, %r15
               	cmpq	$0x0, %r15
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	movabsq	$-0x80, %rax
               	movb	%al, -0x18(%rbp)
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movl	$0x71, %r12d
               	movl	%r12d, (%r14)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	%rax, %r15
               	leaq	<rip>, %r14
               	movl	$0x49, %ebx
               	movq	%r15, %rdi
               	movq	%r12, %rcx
               	movq	%rbx, %rdx
               	movq	%r14, %rsi
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
               	leaq	<rip>, %rbx
               	movl	$0x72, %r12d
               	movl	%r12d, (%rbx)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	<addr>
               	movq	%rax, %r14
               	leaq	<rip>, %rbx
               	movl	$0x4b, %r15d
               	movq	%r14, %rdi
               	movq	%r12, %rcx
               	movq	%r15, %rdx
               	movq	%rbx, %rsi
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
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	<addr>
               	movl	$0xffff, %eax           # imm = 0xFFFF
               	movw	%ax, -0x20(%rbp)
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	movl	$0x73, %r12d
               	movl	%r12d, (%rbx)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	<addr>
               	movq	%rax, %r14
               	leaq	<rip>, %rbx
               	movl	$0x4d, %r15d
               	movq	%r14, %rdi
               	movq	%r12, %rcx
               	movq	%r15, %rdx
               	movq	%rbx, %rsi
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
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	leaq	-0x20(%rbp), %rax
               	movzwq	(%rax), %r14
               	addq	$0x1, %r14
               	movw	%r14w, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movl	$0x78, %r12d
               	movl	%r12d, (%r15)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	<rip>, %r15
               	movl	$0x53, %r14d
               	movq	%rbx, %rdi
               	movq	%r12, %rcx
               	movq	%r14, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movzwq	-0x20(%rbp), %r14
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r14
               	cmpq	$0x0, %r14
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	xorq	%rax, %rax
               	movw	%ax, -0x20(%rbp)
               	leaq	-0x20(%rbp), %r14
               	movzwq	(%r14), %rax
               	addq	$-0x1, %rax
               	movw	%ax, (%r14)
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movl	$0x79, %r12d
               	movl	%r12d, (%r15)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	<rip>, %r15
               	movl	$0x55, %r14d
               	movq	%rbx, %rdi
               	movq	%r12, %rcx
               	movq	%r14, %rdx
               	movq	%r15, %rsi
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
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	movl	$0x7fff, %r10d          # imm = 0x7FFF
               	movq	%r10, 0xf0(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movl	$0x7a, %r12d
               	movl	%r12d, (%r15)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r14
               	leaq	<rip>, %r15
               	movl	$0x58, %ebx
               	movq	%r14, %rdi
               	movq	%r12, %rcx
               	movq	%rbx, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0xf0(%rsp), %rbx
               	movswq	%bx, %rbx
               	cmpq	$0x7fff, %rbx           # imm = 0x7FFF
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	movabsq	$-0x8000, %r10          # imm = 0x8000
               	movq	%r10, 0xe8(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movl	$0x7b, %r14d
               	movl	%r14d, (%r15)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	<rip>, %r15
               	movl	$0x5b, %r12d
               	movq	%rbx, %rdi
               	movq	%r14, %rcx
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0xe8(%rsp), %r12
               	movswq	%r12w, %r12
               	cmpq	$-0x8000, %r12          # imm = 0x8000
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	movq	0xe8(%rsp), %rax
               	movswq	%ax, %rax
               	movq	%rax, %r10
               	andq	$0xffff, %r10           # imm = 0xFFFF
               	movq	%r10, 0xe0(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movl	$0x7c, %ebx
               	movl	%ebx, (%r15)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	<rip>, %r15
               	movl	$0x5d, %r14d
               	movq	%r12, %rdi
               	movq	%rbx, %rcx
               	movq	%r14, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0xe0(%rsp), %rax
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
               	movslq	%eax, %rax
               	movswq	%ax, %r10
               	movq	%r10, 0xd8(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movl	$0x7d, %r14d
               	movl	%r14d, (%r15)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	<rip>, %r15
               	movl	$0x5f, %ebx
               	movq	%r12, %rdi
               	movq	%r14, %rcx
               	movq	%rbx, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0xd8(%rsp), %rax
               	movswq	%ax, %rax
               	cmpq	$0x2345, %rax           # imm = 0x2345
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	movabsq	$-0x2a, %rax
               	movswq	%ax, %r10
               	movq	%r10, 0xd0(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movl	$0x7e, %ebx
               	movl	%ebx, (%r15)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	<rip>, %r15
               	movl	$0x64, %r14d
               	movq	%r12, %rdi
               	movq	%rbx, %rcx
               	movq	%r14, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0xd0(%rsp), %rax
               	movslq	%eax, %rax
               	cmpq	$-0x2a, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	movl	$0xffff, %r10d          # imm = 0xFFFF
               	movq	%r10, 0xc8(%rsp)
               	movq	0xc8(%rsp), %r10
               	andq	$0xffff, %r10           # imm = 0xFFFF
               	movq	%r10, 0xc0(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movl	$0x7f, %r14d
               	movl	%r14d, (%r15)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	<rip>, %r15
               	movl	$0x69, %ebx
               	movq	%r12, %rdi
               	movq	%r14, %rcx
               	movq	%rbx, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0xc0(%rsp), %r15
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r15
               	xorq	$0xffff, %r15           # imm = 0xFFFF
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r15
               	cmpq	$0x0, %r15
               	sete	%r15b
               	movzbq	%r15b, %r15
               	cmpq	$0x0, %r15
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	movl	$0x80, %r15d
               	movl	%r15d, (%rbx)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r14
               	leaq	<rip>, %rbx
               	movl	$0x6e, %r12d
               	movq	%r14, %rdi
               	movq	%r15, %rcx
               	movq	%r12, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0xc8(%rsp), %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	cmpq	$0xffff, %rax           # imm = 0xFFFF
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	movl	%eax, -0x70(%rbp)
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movl	$0x81, %r15d
               	movl	%r15d, (%r12)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	<rip>, %r12
               	movl	$0x70, %r14d
               	movq	%rbx, %rdi
               	movq	%r15, %rcx
               	movq	%r14, %rdx
               	movq	%r12, %rsi
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
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	leaq	-0x70(%rbp), %rax
               	movl	(%rax), %ebx
               	addq	$0x1, %rbx
               	movl	%ebx, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movl	$0x82, %r15d
               	movl	%r15d, (%r14)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	<rip>, %r14
               	movl	$0x76, %ebx
               	movq	%r12, %rdi
               	movq	%r15, %rcx
               	movq	%rbx, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movl	-0x70(%rbp), %ebx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rbx
               	cmpq	$0x0, %rbx
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	xorq	%rax, %rax
               	movl	%eax, -0x70(%rbp)
               	leaq	-0x70(%rbp), %rbx
               	movl	(%rbx), %eax
               	addq	$-0x1, %rax
               	movl	%eax, (%rbx)
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movl	$0x83, %r15d
               	movl	%r15d, (%r14)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	<rip>, %r14
               	movl	$0x78, %ebx
               	movq	%r12, %rdi
               	movq	%r15, %rcx
               	movq	%rbx, %rdx
               	movq	%r14, %rsi
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
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	movl	$0x7fffffff, %r10d      # imm = 0x7FFFFFFF
               	movq	%r10, 0xb8(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movl	$0x84, %r15d
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
               	movq	0xb8(%rsp), %r12
               	movslq	%r12d, %r12
               	cmpq	$0x7fffffff, %r12       # imm = 0x7FFFFFFF
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	<addr>
               	movabsq	$-0x80000000, %rax      # imm = 0x80000000
               	movslq	%eax, %r10
               	movq	%r10, 0xb0(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movl	$0x85, %ebx
               	movl	%ebx, (%r14)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	<rip>, %r14
               	movl	$0x7e, %r15d
               	movq	%r12, %rdi
               	movq	%rbx, %rcx
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0xb0(%rsp), %rax
               	movslq	%eax, %rax
               	cmpq	$-0x80000000, %rax      # imm = 0x80000000
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	movq	0xb0(%rsp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, 0xa8(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movl	$0x86, %r15d
               	movl	%r15d, (%r14)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	<rip>, %r14
               	movl	$0x80, %ebx
               	movq	%r12, %rdi
               	movq	%r15, %rcx
               	movq	%rbx, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0xa8(%rsp), %rbx
               	cmpq	$-0x80000000, %rbx      # imm = 0x80000000
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	<addr>
               	movq	0xb0(%rsp), %rax
               	movslq	%eax, %rax
               	movl	$0xffffffff, %r12d      # imm = 0xFFFFFFFF
               	andq	%rax, %r12
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movl	$0x87, %r12d
               	movl	%r12d, (%r14)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	<rip>, %r14
               	movl	$0x86, %r15d
               	movq	%rbx, %rdi
               	movq	%r12, %rcx
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x80000000, %r11d      # imm = 0x80000000
               	movq	%r12, %rax
               	cmpq	%r11, %r12
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	movabsq	$-0x1, %rax
               	movq	%rax, -0x98(%rbp)
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movl	$0x88, %r15d
               	movl	%r15d, (%r14)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	<rip>, %r14
               	movq	%rbx, %rdi
               	movq	%r15, %rcx
               	movq	%r15, %rdx
               	movq	%r14, %rsi
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
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	leaq	-0x98(%rbp), %rax
               	movq	(%rax), %rbx
               	addq	$0x1, %rbx
               	movq	%rbx, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movl	$0x8c, %r15d
               	movl	%r15d, (%r14)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	<rip>, %r14
               	movl	$0x8e, %ebx
               	movq	%r12, %rdi
               	movq	%r15, %rcx
               	movq	%rbx, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x98(%rbp), %rbx
               	cmpq	$0x0, %rbx
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	leaq	-0x98(%rbp), %rax
               	movq	(%rax), %rbx
               	addq	$-0x1, %rbx
               	movq	%rbx, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movl	$0x8d, %r15d
               	movl	%r15d, (%r14)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	<rip>, %r14
               	movl	$0x90, %ebx
               	movq	%r12, %rdi
               	movq	%r15, %rcx
               	movq	%rbx, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x98(%rbp), %rbx
               	cmpq	$-0x1, %rbx
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	movabsq	$0x7fffffffffffffff, %r10 # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%r10, 0xa0(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movl	$0x8e, %r15d
               	movl	%r15d, (%r14)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	<rip>, %r14
               	movl	$0x92, %ebx
               	movq	%r12, %rdi
               	movq	%r15, %rcx
               	movq	%rbx, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0xa0(%rsp), %rbx
               	movabsq	$0x7fffffffffffffff, %r11 # imm = 0x7FFFFFFFFFFFFFFF
               	cmpq	%r11, %rbx
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	<addr>
               	movabsq	$-0x1, %r10
               	movq	%r10, 0x98(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movl	$0x8f, %r12d
               	movl	%r12d, (%r14)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	<rip>, %r14
               	movl	$0x95, %r15d
               	movq	%rbx, %rdi
               	movq	%r12, %rcx
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x98(%rsp), %r15
               	sarq	$0x1, %r15
               	cmpq	$-0x1, %r15
               	sete	%r15b
               	movzbq	%r15b, %r15
               	cmpq	$0x0, %r15
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, 0x90(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movl	$0x90, %ebx
               	movl	%ebx, (%r14)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	%rax, %r15
               	leaq	<rip>, %r14
               	movl	$0x9a, %r12d
               	movq	%r15, %rdi
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x90(%rsp), %r12
               	shrq	$0x1, %r12
               	movabsq	$0x4000000000000000, %r11 # imm = 0x4000000000000000
               	cmpq	%r11, %r12
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	movabsq	$-0x1, %r10
               	movq	%r10, 0x88(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movl	$0x91, %r15d
               	movl	%r15d, (%r14)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	<rip>, %r14
               	movl	$0x9d, %ebx
               	movq	%r12, %rdi
               	movq	%r15, %rcx
               	movq	%rbx, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x88(%rsp), %rbx
               	shrq	$0x20, %rbx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rbx
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	<addr>
               	movabsq	$-0x12c, %r10           # imm = 0xFED4
               	movq	%r10, 0x78(%rsp)
               	movq	0x78(%rsp), %r15
               	movslq	%r15d, %r15
               	movsbq	%r15b, %r10
               	movq	%r10, 0x80(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movl	$0x92, %r12d
               	movl	%r12d, (%r14)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	<rip>, %r14
               	movl	$0xa0, %r15d
               	movq	%rbx, %rdi
               	movq	%r12, %rcx
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x80(%rsp), %r14
               	movsbq	%r14b, %r14
               	movl	$0xd4, %ebx
               	movsbq	%bl, %rbx
               	cmpq	%rbx, %r14
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	movl	$0x96, %r14d
               	movl	%r14d, (%rbx)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r15
               	leaq	<rip>, %rbx
               	movl	$0xa9, %r12d
               	movq	%r15, %rdi
               	movq	%r14, %rcx
               	movq	%r12, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x80(%rsp), %rax
               	movsbq	%al, %rax
               	cmpq	$-0x2c, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	<addr>
               	movq	0x78(%rsp), %rax
               	movslq	%eax, %rax
               	movq	%rax, %r10
               	andq	$0xff, %r10
               	movq	%r10, 0x70(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movl	$0x97, %r14d
               	movl	%r14d, (%r12)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	<rip>, %r12
               	movl	$0xaa, %r15d
               	movq	%rbx, %rdi
               	movq	%r14, %rcx
               	movq	%r15, %rdx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x70(%rsp), %rax
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
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movl	$0x98, %r15d
               	movl	%r15d, (%r12)
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	<rip>, %r12
               	movl	$0xaf, %r14d
               	movq	%rbx, %rdi
               	movq	%r15, %rcx
               	movq	%r14, %rdx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x70(%rsp), %rax
               	andq	$0xff, %rax
               	cmpq	$0xd4, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	movl	$0x12345, %eax          # imm = 0x12345
               	movslq	%eax, %rax
               	movswq	%ax, %r10
               	movq	%r10, 0x68(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movl	$0x99, %r15d
               	movl	%r15d, (%r14)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	<rip>, %r14
               	movl	$0xb0, %ebx
               	movq	%r12, %rdi
               	movq	%r15, %rcx
               	movq	%rbx, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x68(%rsp), %rax
               	movswq	%ax, %rax
               	cmpq	$0x2345, %rax           # imm = 0x2345
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movl	$0x9a, %ebx
               	movl	%ebx, (%r14)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	<rip>, %r14
               	movl	$0xb5, %r15d
               	movq	%r12, %rdi
               	movq	%rbx, %rcx
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x68(%rsp), %rax
               	movswq	%ax, %rax
               	cmpq	$0x2345, %rax           # imm = 0x2345
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	movl	$0x1ffff, %eax          # imm = 0x1FFFF
               	movslq	%eax, %rax
               	movswq	%ax, %r10
               	movq	%r10, 0x60(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movl	$0x9b, %ebx
               	movl	%ebx, (%r15)
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, %r14
               	leaq	<rip>, %r15
               	movl	$0xb6, %r12d
               	movq	%r14, %rdi
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x60(%rsp), %rax
               	movswq	%ax, %rax
               	cmpq	$-0x1, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movl	$0x9c, %r12d
               	movl	%r12d, (%r15)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	<addr>
               	movq	%rax, %r14
               	leaq	<rip>, %r15
               	movl	$0xba, %ebx
               	movq	%r14, %rdi
               	movq	%r12, %rcx
               	movq	%rbx, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x60(%rsp), %rax
               	movswq	%ax, %rax
               	cmpq	$-0x1, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	movq	%r10, 0x50(%rsp)
               	movl	$0x1, %r10d
               	movq	%r10, 0x58(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	movl	$0x9d, %r12d
               	movl	%r12d, (%rbx)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	%rax, %r15
               	leaq	<rip>, %rbx
               	movl	$0xbb, %r14d
               	movq	%r15, %rdi
               	movq	%r12, %rcx
               	movq	%r14, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x50(%rsp), %rbx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rbx
               	movq	0x58(%rsp), %r14
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r14
               	cmpq	%r14, %rbx
               	seta	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	movq	0x50(%rsp), %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	movslq	%eax, %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x58(%rsp), %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	movslq	%eax, %r10
               	movq	%r10, 0x48(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movl	$0xa0, %ebx
               	movl	%ebx, (%r14)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	%rax, %r15
               	leaq	<rip>, %r14
               	movl	$0xc2, %r12d
               	movq	%r15, %rdi
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x40(%rsp), %rax
               	movslq	%eax, %rax
               	movq	0x48(%rsp), %r15
               	movslq	%r15d, %r15
               	cmpq	%r15, %rax
               	setl	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	movl	$0x1, %r10d
               	movq	%r10, 0x38(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movl	$0xa1, %r14d
               	movl	%r14d, (%r15)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	<rip>, %r15
               	movl	$0xc5, %ebx
               	movq	%r12, %rdi
               	movq	%r14, %rcx
               	movq	%rbx, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x38(%rsp), %rbx
               	movslq	%ebx, %rbx
               	shlq	$0x1e, %rbx
               	cmpq	$0x40000000, %rbx       # imm = 0x40000000
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	movl	$0x1, %r10d
               	movq	%r10, 0x30(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movl	$0xaa, %r12d
               	movl	%r12d, (%r15)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	<rip>, %r15
               	movl	$0xcd, %r14d
               	movq	%rbx, %rdi
               	movq	%r12, %rcx
               	movq	%r14, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x30(%rsp), %r14
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r14
               	shlq	$0x1f, %r14
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r14
               	movl	$0x80000000, %r11d      # imm = 0x80000000
               	cmpq	%r11, %r14
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	movabsq	$-0x1, %r10
               	movq	%r10, 0x28(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movl	$0xab, %ebx
               	movl	%ebx, (%r15)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	<addr>
               	movq	%rax, %r14
               	leaq	<rip>, %r15
               	movl	$0xcf, %r12d
               	movq	%r14, %rdi
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x28(%rsp), %r12
               	movslq	%r12d, %r12
               	cmpq	$-0x1, %r12
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	movq	%r10, 0x20(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movl	$0xac, %r14d
               	movl	%r14d, (%r15)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	<rip>, %r15
               	movl	$0xd3, %ebx
               	movq	%r12, %rdi
               	movq	%r14, %rcx
               	movq	%rbx, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x20(%rsp), %rbx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rbx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rbx
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movl	$0xad, %r12d
               	movl	%r12d, (%r15)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	<rip>, %r15
               	movl	$0xd5, %r14d
               	movq	%rbx, %rdi
               	movq	%r12, %rcx
               	movq	%r14, %rdx
               	movq	%r15, %rsi
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
               	addq	$0x240, %rsp            # imm = 0x240
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
               	addq	$0x240, %rsp            # imm = 0x240
               	popq	%rbp
               	retq
