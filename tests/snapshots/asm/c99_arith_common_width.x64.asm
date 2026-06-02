
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
               	movq	%r12, 0x8(%rsp)
               	movslq	%edi, %rbx
               	leaq	<rip>, %r12
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r12, %r8
               	movq	(%r8), %r8
               	cmpq	$0x0, %r8
               	je	<addr>
               	movq	%rbx, %rdi
               	shlq	$0x3, %rdi
               	addq	%r12, %rdi
               	movq	(%rdi), %rdi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r8
               	xorq	%rdi, %rdi
               	leaq	<rip>, %rsi
               	movq	%rsi, (%r8)
               	leaq	-0x18(%rbp), %rdx
               	addq	$0x8, %rdx
               	leaq	<rip>, %rsi
               	movq	%rsi, (%rdx)
               	leaq	-0x18(%rbp), %r8
               	addq	$0x10, %r8
               	leaq	<rip>, %rsi
               	movq	%rsi, (%r8)
               	leaq	-0x18(%rbp), %rdx
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rdx
               	movq	(%rdx), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	addq	%r12, %rsi
               	movq	(%rax), %rax
               	movq	%rax, (%rsi)
               	jmp	<addr>
               	shlq	$0x3, %rbx
               	addq	%rbx, %r12
               	movq	(%r12), %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xd0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	addq	$0x1, %r11
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	jmp	<addr>
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	cmpq	$0x0, %r11
               	sete	%r11b
               	movzbq	%r11b, %r11
               	cmpq	$0x0, %r11
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	subq	$0x1, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	jmp	<addr>
               	leaq	<rip>, %r9
               	movl	$0x1, %ebx
               	movl	%ebx, (%r9)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %r9
               	leaq	<rip>, %rsi
               	movl	$0x1a, %edx
               	movq	%r9, %rdi
               	movq	%rbx, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movabsq	$-0x1, %rax
               	movl	$0x1, %edx
               	subq	%rdx, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movl	$0x2, %r12d
               	movl	%r12d, (%rdx)
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x21, %edx
               	movq	%r12, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	movl	$0xfffffffe, %r11d      # imm = 0xFFFFFFFE
               	cmpq	%r11, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movabsq	$-0x1, %rax
               	movl	$0x1, %edi
               	imulq	%rdi, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movl	$0x3, %ebx
               	movl	%ebx, (%rdx)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdx
               	leaq	<rip>, %rsi
               	movl	$0x29, %edi
               	movq	%rbx, %rcx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	movq	%r10, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0xc350, %eax           # imm = 0xC350
               	imulq	%rax, %rax
               	movslq	%eax, %rax
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x4, %r12d
               	movl	%r12d, (%rdi)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rsi
               	leaq	<rip>, %rdi
               	movl	$0x31, %edx
               	movq	%r12, %rcx
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	movq	%r10, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	cmpq	$-0x6afd0700, %rax      # imm = 0x9502F900
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movabsq	$-0x1, %rax
               	movl	$0x1, %edi
               	addq	%rdi, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movl	$0x5, %ebx
               	movl	%ebx, (%rdx)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdx
               	leaq	<rip>, %rsi
               	movl	$0x3e, %edi
               	movq	%rbx, %rcx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	movq	%r10, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movabsq	$-0x1, %rax
               	movl	$0x1, %edx
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x64, %r12d
               	movl	%r12d, (%rdi)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rsi
               	leaq	<rip>, %rdi
               	movl	$0x4b, %edx
               	movq	%r12, %rcx
               	movq	%rsi, %r10
               	movq	%rdi, %rsi
               	movq	%r10, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	cmpq	%rdx, %rax
               	setl	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movabsq	$-0x1, %rax
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movl	$0x65, %ebx
               	movl	%ebx, (%rdx)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdx
               	leaq	<rip>, %rsi
               	movl	$0x54, %edi
               	movq	%rbx, %rcx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	movq	%r10, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rdi, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
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
               	leaq	<rip>, %rdi
               	movl	$0x66, %r12d
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
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movslq	(%rdi), %rdi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
