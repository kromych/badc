
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
               	jmp	<addr>
               	jmp	<addr>
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
               	jmp	<addr>
               	jmp	<addr>
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
               	jmp	<addr>
               	jmp	<addr>
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
               	jmp	<addr>
               	jmp	<addr>
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
               	jmp	<addr>
               	jmp	<addr>
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
               	jmp	<addr>
               	jmp	<addr>
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
               	jmp	<addr>
               	jmp	<addr>
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
               	jmp	<addr>
               	jmp	<addr>
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
               	jmp	<addr>
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
               	jmp	<addr>
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
               	jmp	<addr>
               	movl	$0x7f, %r12d
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
               	cmpq	$0x7f, %r12
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movabsq	$-0x80, %r14
               	movb	%r14b, -0x18(%rbp)
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movl	$0x71, %r15d
               	movl	%r15d, (%rdx)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdx
               	leaq	<rip>, %rsi
               	movl	$0x49, %eax
               	movq	%rdx, %rdi
               	movq	%r15, %rcx
               	movq	%rax, %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %r14
               	jmp	<addr>
               	jmp	<addr>
               	movsbq	-0x18(%rbp), %r14
               	cmpq	$-0x80, %r14
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	-0x18(%rbp), %r15
               	movsbq	(%r15), %rdx
               	addq	$-0x1, %rdx
               	movb	%dl, (%r15)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x72, %r12d
               	movl	%r12d, (%rax)
               	movl	$0x2, %edi
               	callq	<addr>
               	leaq	<rip>, %rsi
               	movl	$0x4b, %edx
               	movq	%rax, %rdi
               	movq	%r12, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %r15
               	jmp	<addr>
               	jmp	<addr>
               	movsbq	-0x18(%rbp), %rdx
               	andq	$0xff, %rdx
               	xorq	$0x7f, %rdx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rdx
               	cmpq	$0x0, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0xffff, %eax           # imm = 0xFFFF
               	movw	%ax, -0x20(%rbp)
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movl	$0x73, %r14d
               	movl	%r14d, (%rsi)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rsi
               	leaq	<rip>, %rdi
               	movl	$0x4d, %edx
               	movq	%r14, %rcx
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
               	jmp	<addr>
               	leaq	-0x20(%rbp), %rax
               	movzwq	(%rax), %rdi
               	addq	$0x1, %rdi
               	movw	%di, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movl	$0x78, %r15d
               	movl	%r15d, (%rdx)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdx
               	leaq	<rip>, %rsi
               	movl	$0x53, %edi
               	movq	%r15, %rcx
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
               	jmp	<addr>
               	xorq	%rax, %rax
               	movw	%ax, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rdx
               	movzwq	(%rdx), %rax
               	addq	$-0x1, %rax
               	movw	%ax, (%rdx)
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movl	$0x79, %r14d
               	movl	%r14d, (%rsi)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rsi
               	leaq	<rip>, %rdi
               	movl	$0x55, %edx
               	movq	%r14, %rcx
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
               	jmp	<addr>
               	movl	$0x7fff, %eax           # imm = 0x7FFF
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x7a, %r15d
               	movl	%r15d, (%rdi)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdx
               	leaq	<rip>, %rsi
               	movl	$0x58, %edi
               	movq	%r15, %rcx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	movq	%r10, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	cmpq	$0x7fff, %rax           # imm = 0x7FFF
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movabsq	$-0x8000, %r15          # imm = 0x8000
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x7b, %r14d
               	movl	%r14d, (%rdi)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rsi
               	leaq	<rip>, %rdi
               	movl	$0x5b, %edx
               	movq	%r14, %rcx
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	movq	%r10, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	cmpq	$-0x8000, %r15          # imm = 0x8000
               	sete	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	andq	$0xffff, %r15           # imm = 0xFFFF
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x7c, %r12d
               	movl	%r12d, (%rdi)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rsi
               	leaq	<rip>, %rdi
               	movl	$0x5d, %edx
               	movq	%r12, %rcx
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	movq	%r10, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	andq	$0xffff, %r15           # imm = 0xFFFF
               	xorq	$0x8000, %r15           # imm = 0x8000
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r15
               	cmpq	$0x0, %r15
               	sete	%r15b
               	movzbq	%r15b, %r15
               	cmpq	$0x0, %r15
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x12345, %edi          # imm = 0x12345
               	movswq	%di, %rdi
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x7d, %r14d
               	movl	%r14d, (%rax)
               	movl	$0x2, %edi
               	callq	<addr>
               	leaq	<rip>, %rsi
               	movl	$0x5f, %edx
               	movq	%rax, %rdi
               	movq	%r14, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rdi
               	jmp	<addr>
               	jmp	<addr>
               	movswq	%di, %rdi
               	cmpq	$0x2345, %rdi           # imm = 0x2345
               	sete	%dil
               	movzbq	%dil, %rdi
               	cmpq	$0x0, %rdi
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movabsq	$-0x2a, %r14
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movl	$0x7e, %r15d
               	movl	%r15d, (%rdx)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdx
               	leaq	<rip>, %rsi
               	movl	$0x64, %eax
               	movq	%rdx, %rdi
               	movq	%r15, %rcx
               	movq	%rax, %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %r14
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%r14d, %r14
               	cmpq	$-0x2a, %r14
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0xffff, %r14d          # imm = 0xFFFF
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x7f, %ebx
               	movl	%ebx, (%rax)
               	movl	$0x2, %edi
               	callq	<addr>
               	leaq	<rip>, %rsi
               	movl	$0x69, %edx
               	movq	%rax, %rdi
               	movq	%rbx, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %r15
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0xffffffff, %edx       # imm = 0xFFFFFFFF
               	andq	%r14, %rdx
               	xorq	$0xffff, %rdx           # imm = 0xFFFF
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rdx
               	cmpq	$0x0, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movl	$0x80, %r15d
               	movl	%r15d, (%rsi)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rsi
               	leaq	<rip>, %rdi
               	movl	$0x6e, %edx
               	movq	%r15, %rcx
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	movq	%r10, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	cmpq	$0xffff, %r14           # imm = 0xFFFF
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	movl	%edi, -0x70(%rbp)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x81, %r12d
               	movl	%r12d, (%rax)
               	movl	$0x2, %edi
               	callq	<addr>
               	leaq	<rip>, %rsi
               	movl	$0x70, %edx
               	movq	%rax, %rdi
               	movq	%r12, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rdi
               	jmp	<addr>
               	jmp	<addr>
               	movl	-0x70(%rbp), %edi
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rdi
               	sete	%dil
               	movzbq	%dil, %rdi
               	cmpq	$0x0, %rdi
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	-0x70(%rbp), %r12
               	movl	(%r12), %eax
               	addq	$0x1, %rax
               	movl	%eax, (%r12)
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movl	$0x82, %r14d
               	movl	%r14d, (%rdx)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdx
               	leaq	<rip>, %rsi
               	movl	$0x76, %eax
               	movq	%rdx, %rdi
               	movq	%r14, %rcx
               	movq	%rax, %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %r12
               	jmp	<addr>
               	jmp	<addr>
               	movl	-0x70(%rbp), %eax
               	cmpq	$0x0, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	movl	%eax, -0x70(%rbp)
               	leaq	-0x70(%rbp), %rdx
               	movl	(%rdx), %eax
               	addq	$-0x1, %rax
               	movl	%eax, (%rdx)
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movl	$0x83, %ebx
               	movl	%ebx, (%rsi)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rsi
               	leaq	<rip>, %rdi
               	movl	$0x78, %edx
               	movq	%rbx, %rcx
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
               	jmp	<addr>
               	movl	$0x7fffffff, %eax       # imm = 0x7FFFFFFF
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x84, %r12d
               	movl	%r12d, (%rdi)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdx
               	leaq	<rip>, %rsi
               	movl	$0x7b, %edi
               	movq	%r12, %rcx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	movq	%r10, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	cmpq	$0x7fffffff, %rax       # imm = 0x7FFFFFFF
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movabsq	$-0x80000000, %r12      # imm = 0x80000000
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x85, %ebx
               	movl	%ebx, (%rdi)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rsi
               	leaq	<rip>, %rdi
               	movl	$0x7e, %edx
               	movq	%rbx, %rcx
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	movq	%r10, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	cmpq	$-0x80000000, %r12      # imm = 0x80000000
               	sete	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x86, %r14d
               	movl	%r14d, (%rdi)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rsi
               	leaq	<rip>, %rdi
               	movl	$0x80, %edx
               	movq	%r14, %rcx
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	movq	%r10, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	cmpq	$-0x80000000, %r12      # imm = 0x80000000
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r12
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movl	$0x87, %r15d
               	movl	%r15d, (%rdx)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdx
               	leaq	<rip>, %rsi
               	movl	$0x86, %edi
               	movq	%r15, %rcx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	movq	%r10, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x80000000, %r11d      # imm = 0x80000000
               	cmpq	%r11, %r12
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movabsq	$-0x1, %rdi
               	movq	%rdi, -0x98(%rbp)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x88, %r14d
               	movl	%r14d, (%rax)
               	movl	$0x2, %edi
               	callq	<addr>
               	leaq	<rip>, %rsi
               	movq	%rax, %rdi
               	movq	%r14, %rcx
               	movq	%r14, %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rdi
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x98(%rbp), %rdi
               	cmpq	$-0x1, %rdi
               	sete	%dil
               	movzbq	%dil, %rdi
               	cmpq	$0x0, %rdi
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	-0x98(%rbp), %rax
               	movq	(%rax), %rdx
               	addq	$0x1, %rdx
               	movq	%rdx, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movl	$0x8c, %r12d
               	movl	%r12d, (%rsi)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rsi
               	leaq	<rip>, %rdi
               	movl	$0x8e, %edx
               	movq	%r12, %rcx
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
               	jmp	<addr>
               	leaq	-0x98(%rbp), %r12
               	movq	(%r12), %rdx
               	addq	$-0x1, %rdx
               	movq	%rdx, (%r12)
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x8d, %r14d
               	movl	%r14d, (%rdi)
               	movl	$0x2, %edi
               	callq	<addr>
               	leaq	<rip>, %rsi
               	movl	$0x90, %edx
               	movq	%rax, %rdi
               	movq	%r14, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %r12
               	jmp	<addr>
               	jmp	<addr>
               	movq	-0x98(%rbp), %rdx
               	cmpq	$-0x1, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movabsq	$0x7fffffffffffffff, %rax # imm = 0x7FFFFFFFFFFFFFFF
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movl	$0x8e, %ebx
               	movl	%ebx, (%rsi)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rsi
               	leaq	<rip>, %rdi
               	movl	$0x92, %edx
               	movq	%rbx, %rcx
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	movq	%r10, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movabsq	$0x7fffffffffffffff, %r11 # imm = 0x7FFFFFFFFFFFFFFF
               	cmpq	%r11, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movabsq	$-0x1, %rax
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movl	$0x8f, %r12d
               	movl	%r12d, (%rdx)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdx
               	leaq	<rip>, %rsi
               	movl	$0x95, %edi
               	movq	%r12, %rcx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	movq	%r10, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	sarq	$0x1, %rax
               	cmpq	$-0x1, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movabsq	$-0x8000000000000000, %rax # imm = 0x8000000000000000
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x90, %ebx
               	movl	%ebx, (%rdi)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rsi
               	leaq	<rip>, %rdi
               	movl	$0x9a, %edx
               	movq	%rbx, %rcx
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	movq	%r10, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	shrq	$0x1, %rax
               	movabsq	$0x4000000000000000, %r11 # imm = 0x4000000000000000
               	cmpq	%r11, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movabsq	$-0x1, %rax
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movl	$0x91, %r12d
               	movl	%r12d, (%rdx)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdx
               	leaq	<rip>, %rsi
               	movl	$0x9d, %edi
               	movq	%r12, %rcx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	movq	%r10, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	shrq	$0x20, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movabsq	$-0x12c, %r12           # imm = 0xFED4
               	movsbq	%r12b, %r14
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x92, %ebx
               	movl	%ebx, (%rdi)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rsi
               	leaq	<rip>, %rdi
               	movl	$0xa0, %edx
               	movq	%rbx, %rcx
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	movq	%r10, %rdi
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
               	jmp	<addr>
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
               	movsbq	%r14b, %r14
               	cmpq	$-0x2c, %r14
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	andq	$0xff, %r12
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movl	$0x97, %ebx
               	movl	%ebx, (%rdx)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdx
               	leaq	<rip>, %rsi
               	movl	$0xaa, %eax
               	movq	%rdx, %rdi
               	movq	%rbx, %rcx
               	movq	%rax, %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rdi
               	jmp	<addr>
               	jmp	<addr>
               	movq	%r12, %rdi
               	andq	$0xff, %rdi
               	xorq	$0xd4, %rdi
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rdi
               	cmpq	$0x0, %rdi
               	sete	%dil
               	movzbq	%dil, %rdi
               	cmpq	$0x0, %rdi
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x98, %r14d
               	movl	%r14d, (%rax)
               	movl	$0x2, %edi
               	callq	<addr>
               	leaq	<rip>, %rsi
               	movl	$0xaf, %edx
               	movq	%rax, %rdi
               	movq	%r14, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rbx
               	jmp	<addr>
               	jmp	<addr>
               	andq	$0xff, %r12
               	cmpq	$0xd4, %r12
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x12345, %eax          # imm = 0x12345
               	movswq	%ax, %rbx
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movl	$0x99, %r15d
               	movl	%r15d, (%rdx)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdx
               	leaq	<rip>, %rsi
               	movl	$0xb0, %edi
               	movq	%r15, %rcx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	movq	%r10, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movswq	%bx, %rax
               	cmpq	$0x2345, %rax           # imm = 0x2345
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movl	$0x9a, %r12d
               	movl	%r12d, (%rsi)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rsi
               	leaq	<rip>, %rdi
               	movl	$0xb5, %edx
               	movq	%r12, %rcx
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	movq	%r10, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movswq	%bx, %rbx
               	cmpq	$0x2345, %rbx           # imm = 0x2345
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x1ffff, %edi          # imm = 0x1FFFF
               	movswq	%di, %rbx
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movl	$0x9b, %r15d
               	movl	%r15d, (%rdx)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdx
               	leaq	<rip>, %rsi
               	movl	$0xb6, %eax
               	movq	%rdx, %rdi
               	movq	%r15, %rcx
               	movq	%rax, %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rdi
               	jmp	<addr>
               	jmp	<addr>
               	movswq	%bx, %rdi
               	cmpq	$-0x1, %rdi
               	sete	%dil
               	movzbq	%dil, %rdi
               	cmpq	$0x0, %rdi
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movl	$0x9c, %r14d
               	movl	%r14d, (%rsi)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rsi
               	leaq	<rip>, %rdi
               	movl	$0xba, %edx
               	movq	%r14, %rcx
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	movq	%r10, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movswq	%bx, %rbx
               	cmpq	$-0x1, %rbx
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0xffffffff, %ebx       # imm = 0xFFFFFFFF
               	movl	$0x1, %r15d
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movl	$0x9d, %r12d
               	movl	%r12d, (%rdx)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdx
               	leaq	<rip>, %rsi
               	movl	$0xbb, %eax
               	movq	%rdx, %rdi
               	movq	%r12, %rcx
               	movq	%rax, %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rdi
               	jmp	<addr>
               	jmp	<addr>
               	cmpq	%r15, %rbx
               	seta	%sil
               	movzbq	%sil, %rsi
               	cmpq	$0x0, %rsi
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%ebx, %rbx
               	movslq	%r15d, %r15
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movl	$0xa0, %r14d
               	movl	%r14d, (%rdx)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdx
               	leaq	<rip>, %rsi
               	movl	$0xc2, %edi
               	movq	%r14, %rcx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	movq	%r10, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%ebx, %rbx
               	movslq	%r15d, %r15
               	cmpq	%r15, %rbx
               	setl	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movl	$0xa1, %r12d
               	movl	%r12d, (%r15)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %r15
               	leaq	<rip>, %rsi
               	movl	$0xc5, %edx
               	movq	%r15, %rdi
               	movq	%r12, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	shlq	$0x1e, %rax
               	cmpq	$0x40000000, %rax       # imm = 0x40000000
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movl	$0xaa, %ebx
               	movl	%ebx, (%rdx)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdx
               	leaq	<rip>, %rsi
               	movl	$0xcd, %r15d
               	movq	%rdx, %rdi
               	movq	%rbx, %rcx
               	movq	%r15, %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	shlq	$0x1f, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	movl	$0x80000000, %r11d      # imm = 0x80000000
               	cmpq	%r11, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movabsq	$-0x1, %rax
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movl	$0xab, %r12d
               	movl	%r12d, (%r15)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %r15
               	leaq	<rip>, %rsi
               	movl	$0xcf, %edx
               	movq	%r15, %rdi
               	movq	%r12, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	cmpq	$-0x1, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movl	$0xac, %ebx
               	movl	%ebx, (%rdx)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdx
               	leaq	<rip>, %rsi
               	movl	$0xd3, %r15d
               	movq	%rdx, %rdi
               	movq	%rbx, %rcx
               	movq	%r15, %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movl	$0xad, %r12d
               	movl	%r12d, (%r15)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %r15
               	leaq	<rip>, %rsi
               	movl	$0xd5, %edx
               	movq	%r15, %rdi
               	movq	%r12, %rcx
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
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
