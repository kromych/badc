
alloca_spill_arith.x64:	file format elf64-x86-64

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
               	subq	$0x150, %rsp            # imm = 0x150
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
               	movl	$0x10000, %eax          # imm = 0x10000
               	movq	%rax, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rax
               	subq	%r11, %rax
               	movq	%rax, %rsp
               	movl	$0x1, %ecx
               	movb	%cl, (%rax)
               	movl	$0x2, %ecx
               	movb	%cl, 0x1(%rax)
               	movl	$0x3, %ecx
               	movb	%cl, 0x2(%rax)
               	movl	$0x4, %ecx
               	movb	%cl, 0x3(%rax)
               	movl	$0x5, %ecx
               	movb	%cl, 0x4(%rax)
               	movl	$0x6, %ecx
               	movb	%cl, 0x5(%rax)
               	leaq	0xffff(%rax), %rcx
               	movl	$0x7, %edx
               	movb	%dl, (%rcx)
               	movzbq	(%rax), %r15
               	movzbq	0x1(%rax), %rbx
               	movzbq	0x2(%rax), %r12
               	movzbq	0x3(%rax), %r13
               	movzbq	0x4(%rax), %r14
               	movzbq	0x5(%rax), %r10
               	movq	%r10, -0xf8(%rbp)
               	leaq	(%r15,%rbx), %rdx
               	leaq	(%r12,%r13), %rcx
               	movq	%r14, %rsi
               	addq	-0xf8(%rbp), %rsi
               	leaq	(%rdx,%rdx,2), %rdi
               	leaq	(%rcx,%rcx,4), %r8
               	imulq	$0x7, %rsi, %r9
               	cmpq	%rcx, %rdx
               	jge	<addr>
               	movq	%rdi, -0x100(%rbp)
               	cmpq	%rsi, %rcx
               	jge	<addr>
               	movq	%r8, -0x108(%rbp)
               	cmpq	%rdx, %rsi
               	jge	<addr>
               	movq	%r9, -0x110(%rbp)
               	leaq	(%r15,%rbx), %r10
               	movq	%r10, -0x118(%rbp)
               	movq	-0x118(%rbp), %r10
               	addq	%r12, %r10
               	movq	%r10, -0x118(%rbp)
               	movq	-0x118(%rbp), %r10
               	addq	%r13, %r10
               	movq	%r10, -0x118(%rbp)
               	movq	-0x118(%rbp), %r10
               	addq	%r14, %r10
               	movq	%r10, -0x118(%rbp)
               	movq	-0x118(%rbp), %r10
               	addq	-0xf8(%rbp), %r10
               	movq	%r10, -0x118(%rbp)
               	movq	-0x118(%rbp), %r10
               	addq	%rdx, %r10
               	movq	%r10, -0x118(%rbp)
               	movq	-0x118(%rbp), %r10
               	addq	%rcx, %r10
               	movq	%r10, -0x118(%rbp)
               	movq	-0x118(%rbp), %r10
               	addq	%rsi, %r10
               	movq	%r10, -0x118(%rbp)
               	movq	-0x118(%rbp), %r10
               	addq	%rdi, %r10
               	movq	%r10, -0x118(%rbp)
               	movq	-0x118(%rbp), %r10
               	addq	%r8, %r10
               	movq	%r10, -0x118(%rbp)
               	movq	-0x118(%rbp), %r10
               	addq	%r9, %r10
               	movq	%r10, -0x118(%rbp)
               	movq	-0x118(%rbp), %r10
               	addq	-0x100(%rbp), %r10
               	movq	%r10, -0x100(%rbp)
               	movq	-0x100(%rbp), %r10
               	addq	-0x108(%rbp), %r10
               	movq	%r10, -0x100(%rbp)
               	movq	-0x100(%rbp), %r10
               	addq	-0x110(%rbp), %r10
               	movq	%r10, -0x100(%rbp)
               	cmpq	%rbx, %r15
               	setl	%r15b
               	movzbq	%r15b, %r15
               	cmpq	%r12, %rbx
               	setl	%bl
               	movzbq	%bl, %rbx
               	addq	%r15, %rbx
               	cmpq	%r13, %r12
               	setl	%r12b
               	movzbq	%r12b, %r12
               	addq	%r12, %rbx
               	cmpq	%r14, %r13
               	setl	%r12b
               	movzbq	%r12b, %r12
               	addq	%r12, %rbx
               	cmpq	-0xf8(%rbp), %r14
               	setl	%r12b
               	movzbq	%r12b, %r12
               	addq	%r12, %rbx
               	cmpq	%rcx, %rdx
               	setg	%dl
               	movzbq	%dl, %rdx
               	addq	%rbx, %rdx
               	cmpq	%rsi, %rcx
               	setg	%cl
               	movzbq	%cl, %rcx
               	addq	%rdx, %rcx
               	cmpq	%r8, %rdi
               	setne	%dl
               	movzbq	%dl, %rdx
               	addq	%rdx, %rcx
               	cmpq	%r9, %r8
               	setne	%dl
               	movzbq	%dl, %rdx
               	addq	%rdx, %rcx
               	cmpq	%rdi, %r9
               	setne	%dl
               	movzbq	%dl, %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movq	-0x100(%rbp), %rdx
               	addq	%rcx, %rdx
               	xorq	%rcx, %rcx
               	movzbq	(%rax), %rsi
               	leaq	0xffff(%rax), %rdi
               	movzbq	(%rdi), %rdi
               	addq	%rdi, %rsi
               	movzbq	0x2(%rax), %rdi
               	movzbq	0x3(%rax), %rax
               	addq	%rdi, %rax
               	cmpq	$0xe0, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	cmpq	$0x8, %rsi
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	cmpq	$0x7, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x2a, %eax
               	movslq	%eax, %rax
               	leaq	-0x150(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rdi, -0x110(%rbp)
               	jmp	<addr>
               	movq	%r9, -0x108(%rbp)
               	jmp	<addr>
               	movq	%r8, -0x100(%rbp)
               	jmp	<addr>
