
integer_ops_exhaustive.x64:	file format elf64-x86-64

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
               	movl	$0xfffffffe, %ebx       # imm = 0xFFFFFFFE
               	movl	$0x1, %r12d
               	jmp	<addr>
               	movl	$0xffffffff, %r8d       # imm = 0xFFFFFFFF
               	andq	%rbx, %r8
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	andq	%r12, %rdi
               	cmpq	%rdi, %r8
               	seta	%r8b
               	movzbq	%r8b, %r8
               	cmpq	$0x0, %r8
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r14
               	leaq	<rip>, %r15
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r12, %rax
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%rbx, %r15
               	cmpq	%r15, %rax
               	setb	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r14
               	leaq	<rip>, %r15
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%rbx, %rax
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%r12, %r15
               	cmpq	%r15, %rax
               	setae	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r14
               	leaq	<rip>, %r15
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r12, %rax
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%rbx, %r15
               	cmpq	%r15, %rax
               	setbe	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r14
               	leaq	<rip>, %r15
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%rbx, %rax
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%r12, %r15
               	cmpq	%r15, %rax
               	setne	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r14
               	leaq	<rip>, %r15
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%rbx, %rax
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%r12, %r15
               	cmpq	%r15, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	<addr>
               	movabsq	$-0x2, %r14
               	movl	$0x1, %ebx
               	jmp	<addr>
               	leaq	<rip>, %r14
               	leaq	<rip>, %r15
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movslq	%r14d, %r12
               	movslq	%ebx, %r15
               	cmpq	%r15, %r12
               	setl	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r15
               	leaq	<rip>, %r12
               	movq	%r15, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movslq	%ebx, %rax
               	movslq	%r14d, %r12
               	cmpq	%r12, %rax
               	setg	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r15
               	leaq	<rip>, %r12
               	movq	%r15, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movslq	%r14d, %rax
               	movslq	%ebx, %r12
               	cmpq	%r12, %rax
               	setle	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r15
               	leaq	<rip>, %r12
               	movq	%r15, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movslq	%ebx, %rax
               	movslq	%r14d, %r12
               	cmpq	%r12, %rax
               	setge	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	movabsq	$-0x2, %r15
               	movl	$0x1, %r14d
               	jmp	<addr>
               	leaq	<rip>, %r15
               	leaq	<rip>, %r12
               	movq	%r15, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	<addr>
               	cmpq	%r14, %r15
               	seta	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r12
               	leaq	<rip>, %rbx
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	<addr>
               	cmpq	%r14, %r15
               	setae	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r12
               	leaq	<rip>, %rbx
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	<addr>
               	cmpq	%r15, %r14
               	setb	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	movabsq	$-0x2, %r12
               	movl	$0x1, %r15d
               	jmp	<addr>
               	leaq	<rip>, %r12
               	leaq	<rip>, %rbx
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	<addr>
               	cmpq	%r12, %r15
               	setg	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	leaq	<rip>, %r14
               	movq	%rbx, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	<addr>
               	cmpq	$0x0, %r12
               	setl	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	movl	$0xfe, %r15d
               	movl	$0x1, %ebx
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	leaq	<rip>, %r14
               	movq	%rbx, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movq	%r15, %r12
               	andq	$0xff, %r12
               	movq	%rbx, %r14
               	andq	$0xff, %r14
               	cmpq	%r14, %r12
               	setg	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r14
               	leaq	<rip>, %r12
               	movq	%r14, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movq	%rbx, %rax
               	andq	$0xff, %rax
               	movq	%r15, %r12
               	andq	$0xff, %r12
               	cmpq	%r12, %rax
               	setl	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	movabsq	$-0x2, %r14
               	movl	$0x1, %r15d
               	jmp	<addr>
               	leaq	<rip>, %r14
               	leaq	<rip>, %r12
               	movq	%r14, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movsbq	%r14b, %rbx
               	movsbq	%r15b, %r12
               	cmpq	%r12, %rbx
               	setl	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %r12
               	leaq	<rip>, %rbx
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movsbq	%r15b, %rax
               	movsbq	%r14b, %rbx
               	cmpq	%rbx, %rax
               	setg	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	movl	$0x64, %eax
               	movl	%eax, -0x68(%rbp)
               	leaq	-0x68(%rbp), %rbx
               	movl	(%rbx), %eax
               	addq	$0x5, %rax
               	movl	%eax, (%rbx)
               	jmp	<addr>
               	leaq	<rip>, %r12
               	leaq	<rip>, %rbx
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	-0x68(%rbp), %r15d
               	xorq	$0x69, %r15
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r15
               	cmpq	$0x0, %r15
               	sete	%r15b
               	movzbq	%r15b, %r15
               	cmpq	$0x0, %r15
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	leaq	-0x68(%rbp), %rax
               	movl	(%rax), %ebx
               	subq	$0xa, %rbx
               	movl	%ebx, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %r12
               	leaq	<rip>, %rbx
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	-0x68(%rbp), %r12d
               	xorq	$0x5f, %r12
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r12
               	cmpq	$0x0, %r12
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	leaq	-0x68(%rbp), %rax
               	movl	(%rax), %r14d
               	shlq	$0x1, %r14
               	movl	%r14d, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %r15
               	leaq	<rip>, %r14
               	movq	%r15, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	-0x68(%rbp), %r15d
               	xorq	$0xbe, %r15
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
               	leaq	-0x68(%rbp), %rax
               	movl	(%rax), %r12d
               	movl	$0x5, %ebx
               	movq	%rbx, %r11
               	pushq	%rax
               	pushq	%rdx
               	movq	%r12, %rax
               	xorq	%rdx, %rdx
               	divq	%r11
               	movq	%rax, %r12
               	popq	%rdx
               	popq	%rax
               	movl	%r12d, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	leaq	<rip>, %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	-0x68(%rbp), %ebx
               	xorq	$0x26, %rbx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rbx
               	cmpq	$0x0, %rbx
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	<addr>
               	leaq	-0x68(%rbp), %rax
               	movl	(%rax), %r15d
               	movl	$0x7, %r14d
               	movq	%r14, %r11
               	pushq	%rax
               	pushq	%rdx
               	movq	%r15, %rax
               	xorq	%rdx, %rdx
               	divq	%r11
               	movq	%rdx, %r15
               	popq	%rdx
               	popq	%rax
               	movl	%r15d, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %r14
               	leaq	<rip>, %r15
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	-0x68(%rbp), %r14d
               	xorq	$0x3, %r14
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r14
               	cmpq	$0x0, %r14
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	movl	$0x1, %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	subq	$0x2, %rax
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%rax, %r15
               	jmp	<addr>
               	leaq	<rip>, %r12
               	leaq	<rip>, %rbx
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
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
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	movl	$0x3e8, %eax            # imm = 0x3E8
               	movq	%rax, -0x78(%rbp)
               	leaq	-0x78(%rbp), %r12
               	movq	(%r12), %rax
               	addq	$0x19f, %rax            # imm = 0x19F
               	movq	%rax, (%r12)
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	leaq	<rip>, %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movq	-0x78(%rbp), %rax
               	cmpq	$0x587, %rax            # imm = 0x587
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	<addr>
               	leaq	-0x78(%rbp), %rax
               	movq	(%rax), %r15
               	movl	$0x3, %r11d
               	imulq	%r11, %r15
               	movq	%r15, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %r14
               	leaq	<rip>, %r15
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movq	-0x78(%rbp), %r15
               	cmpq	$0x1095, %r15           # imm = 0x1095
               	sete	%r15b
               	movzbq	%r15b, %r15
               	cmpq	$0x0, %r15
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	leaq	-0x78(%rbp), %rax
               	movq	(%rax), %r14
               	movl	$0x5, %r12d
               	movq	%r12, %r11
               	pushq	%rax
               	pushq	%rdx
               	movq	%r14, %rax
               	xorq	%rdx, %rdx
               	divq	%r11
               	movq	%rax, %r14
               	popq	%rdx
               	popq	%rax
               	movq	%r14, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %r12
               	leaq	<rip>, %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movq	-0x78(%rbp), %r14
               	cmpq	$0x351, %r14            # imm = 0x351
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	movl	$0xff00ff00, %eax       # imm = 0xFF00FF00
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	movq	%rax, %r14
               	andq	$0xf0f0f0f, %r14        # imm = 0xF0F0F0F
               	movq	%rax, %r12
               	orq	$0xff000, %r12          # imm = 0xFF000
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	xorq	%rax, %r10
               	movq	%r10, 0x20(%rsp)
               	xorq	$-0x1, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%rax, %r10
               	movq	%r10, 0x28(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %r15
               	leaq	<rip>, %r12
               	movq	%r15, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r14, %rax
               	xorq	$0xf000f00, %rax        # imm = 0xF000F00
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
               	leaq	<rip>, %r15
               	movq	%rbx, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r12, %rax
               	movl	$0xff0fff00, %r11d      # imm = 0xFF0FFF00
               	cmpq	%r11, %rax
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
               	leaq	<rip>, %r15
               	movq	%rbx, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movq	0x20(%rsp), %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	xorq	$0xff00ff, %rax         # imm = 0xFF00FF
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
               	leaq	<rip>, %r14
               	leaq	<rip>, %r15
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movq	0x28(%rsp), %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	xorq	$0xff00ff, %rax         # imm = 0xFF00FF
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
               	movl	$0x12345678, %eax       # imm = 0x12345678
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	shlq	$0x4, %rax
               	movl	$0xffffffff, %r14d      # imm = 0xFFFFFFFF
               	andq	%rax, %r14
               	jmp	<addr>
               	leaq	<rip>, %r12
               	leaq	<rip>, %r15
               	movq	%r12, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r14, %rax
               	xorq	$0x23456780, %rax       # imm = 0x23456780
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
               	movl	$0x1, %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	shlq	$0x1f, %rax
               	movl	$0xffffffff, %ebx       # imm = 0xFFFFFFFF
               	andq	%rax, %rbx
               	jmp	<addr>
               	leaq	<rip>, %r15
               	leaq	<rip>, %r12
               	movq	%r15, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%rbx, %rax
               	movl	$0x80000000, %r11d      # imm = 0x80000000
               	cmpq	%r11, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	movl	$0x1, %r15d
               	jmp	<addr>
               	leaq	<rip>, %r12
               	leaq	<rip>, %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movq	%r15, %r14
               	shlq	$0x3f, %r14
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	cmpq	%r11, %r14
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	movabsq	$-0x1, %r14
               	movl	$0x1, %r12d
               	jmp	<addr>
               	leaq	<rip>, %r12
               	leaq	<rip>, %rbx
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movslq	%r14d, %r15
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r15
               	movl	$0xffffffff, %ebx       # imm = 0xFFFFFFFF
               	andq	%r12, %rbx
               	cmpq	%rbx, %r15
               	seta	%r15b
               	movzbq	%r15b, %r15
               	cmpq	$0x0, %r15
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	leaq	<rip>, %r15
               	movq	%rbx, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movslq	%r14d, %rax
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%r12, %r15
               	movslq	%r15d, %r15
               	cmpq	%r15, %rax
               	setl	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	<addr>
               	movl	$0xfffffffe, %eax       # imm = 0xFFFFFFFE
               	movl	%eax, -0xe0(%rbp)
               	leaq	-0xe0(%rbp), %r15
               	movl	(%r15), %eax
               	addq	$0x1, %rax
               	movl	%eax, (%r15)
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	leaq	<rip>, %r15
               	movq	%rbx, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	-0xe0(%rbp), %r12d
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %r12
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	<addr>
               	leaq	-0xe0(%rbp), %rax
               	movl	(%rax), %r15d
               	addq	$0x1, %r15
               	movl	%r15d, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	leaq	<rip>, %r15
               	movq	%rbx, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	-0xe0(%rbp), %ebx
               	cmpq	$0x0, %rbx
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	movl	$0xfe, %eax
               	movb	%al, -0xe8(%rbp)
               	leaq	-0xe8(%rbp), %r14
               	movzbq	(%r14), %rax
               	addq	$0x1, %rax
               	movb	%al, (%r14)
               	jmp	<addr>
               	leaq	<rip>, %r12
               	leaq	<rip>, %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movzbq	-0xe8(%rbp), %r12
               	xorq	$0xff, %r12
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r12
               	cmpq	$0x0, %r12
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	leaq	-0xe8(%rbp), %rax
               	movzbq	(%rax), %r14
               	addq	$0x1, %r14
               	movb	%r14b, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %r15
               	leaq	<rip>, %r14
               	movq	%r15, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movzbq	-0xe8(%rbp), %r15
               	cmpq	$0x0, %r15
               	sete	%r15b
               	movzbq	%r15b, %r15
               	cmpq	$0x0, %r15
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	movabsq	$-0x2, %rax
               	movq	%rax, -0xf0(%rbp)
               	leaq	-0xf0(%rbp), %rbx
               	movq	(%rbx), %rax
               	addq	$0x1, %rax
               	movq	%rax, (%rbx)
               	jmp	<addr>
               	leaq	<rip>, %r12
               	leaq	<rip>, %rbx
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movq	-0xf0(%rbp), %rax
               	cmpq	$-0x1, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	leaq	-0xf0(%rbp), %rax
               	movq	(%rax), %r12
               	addq	$0x1, %r12
               	movq	%r12, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %r14
               	leaq	<rip>, %r12
               	movq	%r14, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movq	-0xf0(%rbp), %r12
               	cmpq	$0x0, %r12
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	leaq	<rip>, %r14
               	movq	%rbx, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
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
               	leaq	<rip>, %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x1, %eax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	leaq	<rip>, %r14
               	movq	%rbx, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
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
               	leaq	<rip>, %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x1, %eax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	leaq	<rip>, %r14
               	movq	%rbx, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
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
               	leaq	<rip>, %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x1, %eax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rbx
               	leaq	<rip>, %r14
               	movq	%rbx, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
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
               	leaq	<rip>, %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x1, %eax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	<addr>
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
               	leaq	<rip>, %rbx
               	leaq	<rip>, %r14
               	movq	%rbx, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	<addr>
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
