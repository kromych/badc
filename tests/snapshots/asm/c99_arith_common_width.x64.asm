
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
               	subq	$0xe0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	addq	$0x1, %r11
               	movl	$0xffffffff, %ebx       # imm = 0xFFFFFFFF
               	andq	%r11, %rbx
               	jmp	<addr>
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%rbx, %r11
               	cmpq	$0x0, %r11
               	sete	%r11b
               	movzbq	%r11b, %r11
               	cmpq	$0x0, %r11
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	xorq	%rax, %rax
               	subq	$0x1, %rax
               	movl	$0xffffffff, %r14d      # imm = 0xFFFFFFFF
               	andq	%rax, %r14
               	jmp	<addr>
               	leaq	<rip>, %r8
               	movl	$0x1, %r12d
               	movl	%r12d, (%r8)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %r8
               	leaq	<rip>, %rsi
               	movl	$0x1a, %edx
               	movq	%r8, %rdi
               	movq	%r12, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r14, %rax
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
               	movabsq	$-0x1, %rax
               	movl	$0x1, %edx
               	subq	%rdx, %rax
               	movl	$0xffffffff, %r12d      # imm = 0xFFFFFFFF
               	andq	%rax, %r12
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	movl	$0x2, %r15d
               	movl	%r15d, (%rbx)
               	movq	%r15, %rdi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x21, %edx
               	movq	%r15, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r12, %rax
               	movl	$0xfffffffe, %r11d      # imm = 0xFFFFFFFE
               	cmpq	%r11, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	movabsq	$-0x1, %rax
               	movl	$0x1, %edx
               	imulq	%rdx, %rax
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%rax, %r15
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movl	$0x3, %ebx
               	movl	%ebx, (%r14)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %r14
               	leaq	<rip>, %rsi
               	movl	$0x29, %edx
               	movq	%r14, %rdi
               	movq	%rbx, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r15, %rax
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
               	movl	$0xc350, %eax           # imm = 0xC350
               	imulq	%rax, %rax
               	movslq	%eax, %r14
               	jmp	<addr>
               	leaq	<rip>, %r12
               	movl	$0x4, %ebx
               	movl	%ebx, (%r12)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	<rip>, %rsi
               	movl	$0x31, %edx
               	movq	%r12, %rdi
               	movq	%rbx, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	cmpq	$-0x6afd0700, %r14      # imm = 0x9502F900
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	movabsq	$-0x1, %rax
               	movl	$0x1, %edx
               	addq	%rdx, %rax
               	movl	$0xffffffff, %r12d      # imm = 0xFFFFFFFF
               	andq	%rax, %r12
               	jmp	<addr>
               	leaq	<rip>, %r15
               	movl	$0x5, %ebx
               	movl	%ebx, (%r15)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %r15
               	leaq	<rip>, %rsi
               	movl	$0x3e, %edx
               	movq	%r15, %rdi
               	movq	%rbx, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r12, %rax
               	cmpq	$0x0, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	movabsq	$-0x1, %r15
               	movl	$0x1, %ebx
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movl	$0x64, %ebx
               	movl	%ebx, (%r14)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %r14
               	leaq	<rip>, %rsi
               	movl	$0x4b, %edx
               	movq	%r14, %rdi
               	movq	%rbx, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	cmpq	%rbx, %r15
               	setl	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	movabsq	$-0x1, %r12
               	movl	$0xffffffff, %r14d      # imm = 0xFFFFFFFF
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movl	$0x65, %r14d
               	movl	%r14d, (%rsi)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rsi
               	leaq	<rip>, %rdi
               	movl	$0x54, %edx
               	movq	%r14, %rcx
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	movq	%r10, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	%r12, %rbx
               	xorq	%r14, %rbx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rbx
               	cmpq	$0x0, %rbx
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
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
               	leaq	<rip>, %r15
               	movl	$0x66, %ebx
               	movl	%ebx, (%r15)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %r15
               	leaq	<rip>, %rsi
               	movl	$0x5d, %edx
               	movq	%r15, %rdi
               	movq	%rbx, %rcx
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
               	addq	$0xe0, %rsp
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
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
