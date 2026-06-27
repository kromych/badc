
integer_ops_exhaustive.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x120, %rsp            # imm = 0x120
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movl	$0xfffffffe, %ebx       # imm = 0xFFFFFFFE
               	movl	$0x1, %r12d
               	cmpq	%r12, %rbx
               	seta	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	jmp	<addr>
               	cmpq	%rbx, %r12
               	setb	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	jmp	<addr>
               	cmpq	%r12, %rbx
               	setae	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	jmp	<addr>
               	cmpq	%rbx, %r12
               	setbe	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	jmp	<addr>
               	cmpq	%r12, %rbx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	jmp	<addr>
               	cmpq	%r12, %rbx
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	jmp	<addr>
               	movabsq	$-0x2, %rbx
               	movl	$0x1, %r12d
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	jmp	<addr>
               	cmpq	%r12, %rbx
               	setl	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	jmp	<addr>
               	cmpq	%rbx, %r12
               	setg	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	jmp	<addr>
               	cmpq	%r12, %rbx
               	setle	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	jmp	<addr>
               	cmpq	%rbx, %r12
               	setge	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	jmp	<addr>
               	movabsq	$-0x2, %rbx
               	movl	$0x1, %r12d
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	jmp	<addr>
               	cmpq	%r12, %rbx
               	seta	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	jmp	<addr>
               	cmpq	%r12, %rbx
               	setae	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	jmp	<addr>
               	cmpq	%rbx, %r12
               	setb	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	jmp	<addr>
               	movabsq	$-0x2, %rbx
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	jmp	<addr>
               	cmpq	%rbx, %rax
               	setg	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	jmp	<addr>
               	testq	%rbx, %rbx
               	setl	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	jmp	<addr>
               	movl	$0xfe, %ebx
               	movl	$0x1, %r12d
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	jmp	<addr>
               	cmpq	%r12, %rbx
               	setg	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	jmp	<addr>
               	cmpq	%rbx, %r12
               	setl	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	jmp	<addr>
               	movabsq	$-0x2, %rbx
               	movl	$0x1, %r12d
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	jmp	<addr>
               	cmpq	%r12, %rbx
               	setl	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	jmp	<addr>
               	cmpq	%rbx, %r12
               	setg	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	jmp	<addr>
               	movl	$0x64, %eax
               	leaq	0x5(%rax), %rbx
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	%ebx, %eax
               	xorq	$0x69, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	jmp	<addr>
               	movl	%ebx, %eax
               	leaq	-0xa(%rax), %rbx
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	%ebx, %eax
               	xorq	$0x5f, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	jmp	<addr>
               	movl	%ebx, %eax
               	movq	%rax, %rbx
               	shlq	$0x1, %rbx
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	%ebx, %eax
               	xorq	$0xbe, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	jmp	<addr>
               	movl	%ebx, %eax
               	movl	$0x5, %ecx
               	pushq	%rax
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%rcx
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	%ebx, %eax
               	xorq	$0x26, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	jmp	<addr>
               	movl	%ebx, %eax
               	movl	$0x7, %ecx
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%rcx
               	movq	%rdx, %rax
               	popq	%rdx
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	%eax, %eax
               	xorq	$0x3, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	jmp	<addr>
               	movl	$0x1, %eax
               	subq	$0x2, %rax
               	movl	%eax, %eax
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	%eax, %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	jmp	<addr>
               	movl	$0x3e8, %eax            # imm = 0x3E8
               	leaq	0x19f(%rax), %rbx
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	jmp	<addr>
               	cmpq	$0x587, %rbx            # imm = 0x587
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	(%rbx,%rbx,2), %rbx
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	jmp	<addr>
               	cmpq	$0x1095, %rbx           # imm = 0x1095
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	jmp	<addr>
               	movl	$0x5, %eax
               	movq	%rax, %r10
               	pushq	%rdx
               	movq	%rbx, %rax
               	xorq	%rdx, %rdx
               	divq	%r10
               	popq	%rdx
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	jmp	<addr>
               	cmpq	$0x351, %rax            # imm = 0x351
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	jmp	<addr>
               	movl	$0xff00ff00, %eax       # imm = 0xFF00FF00
               	movq	%rax, %rcx
               	andq	$0xf0f0f0f, %rcx        # imm = 0xF0F0F0F
               	movq	%rax, %rbx
               	orq	$0xff000, %rbx          # imm = 0xFF000
               	movl	$0xffffffff, %r12d      # imm = 0xFFFFFFFF
               	xorq	%rax, %r12
               	xorq	$-0x1, %rax
               	movl	%eax, %r13d
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	%ecx, %eax
               	xorq	$0xf000f00, %rax        # imm = 0xF000F00
               	movl	%eax, %eax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	%ebx, %eax
               	movl	$0xff0fff00, %r11d      # imm = 0xFF0FFF00
               	cmpq	%r11, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	%r12d, %eax
               	xorq	$0xff00ff, %rax         # imm = 0xFF00FF
               	movl	%eax, %eax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	%r13d, %eax
               	xorq	$0xff00ff, %rax         # imm = 0xFF00FF
               	movl	%eax, %eax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	jmp	<addr>
               	movl	$0x12345678, %eax       # imm = 0x12345678
               	shlq	$0x4, %rax
               	movl	%eax, %eax
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	%eax, %eax
               	xorq	$0x23456780, %rax       # imm = 0x23456780
               	movl	%eax, %eax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	jmp	<addr>
               	movl	$0x1, %eax
               	shlq	$0x1f, %rax
               	movl	%eax, %eax
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	%eax, %eax
               	movl	$0x80000000, %r11d      # imm = 0x80000000
               	cmpq	%r11, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	jmp	<addr>
               	shlq	$0x3f, %rax
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	cmpq	%r11, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	jmp	<addr>
               	movabsq	$-0x1, %rbx
               	movl	$0x1, %r12d
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	%ebx, %eax
               	cmpq	%r12, %rax
               	seta	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movslq	%r12d, %rax
               	cmpq	%rax, %rbx
               	setl	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	jmp	<addr>
               	movl	$0xfffffffe, %eax       # imm = 0xFFFFFFFE
               	leaq	0x1(%rax), %rbx
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	%ebx, %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	jmp	<addr>
               	movl	%ebx, %eax
               	incq	%rax
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	%eax, %eax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	jmp	<addr>
               	movl	$0xfe, %eax
               	leaq	0x1(%rax), %rbx
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movq	%rbx, %rax
               	andq	$0xff, %rax
               	xorq	$0xff, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	jmp	<addr>
               	movq	%rbx, %rax
               	andq	$0xff, %rax
               	incq	%rax
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	jmp	<addr>
               	andq	$0xff, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	jmp	<addr>
               	movabsq	$-0x2, %rax
               	leaq	0x1(%rax), %rbx
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	jmp	<addr>
               	cmpq	$-0x1, %rbx
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	0x1(%rbx), %rax
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	jmp	<addr>
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	jmp	<addr>
               	addb	%al, 0x41(%rdx)
