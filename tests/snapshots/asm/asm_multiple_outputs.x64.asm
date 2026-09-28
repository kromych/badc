
asm_multiple_outputs.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<pair>:
               	movl	$0x12345678, %eax       # imm = 0x12345678
               	movl	$0x9abc, %edx           # imm = 0x9ABC
               	movl	%edx, %ecx
               	shlq	$0x20, %rcx
               	movl	%eax, %eax
               	orq	%rcx, %rax
               	retq

<four>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movl	%edi, %esi
               	movl	%esi, %eax
               	leal	0x1(%rax), %ebx
               	leal	0x2(%rax), %ecx
               	leal	0x3(%rax), %edx
               	imulq	$0x3e8, %rax, %rax      # imm = 0x3E8
               	imulq	$0x64, %rbx, %rsi
               	addq	%rsi, %rax
               	imulq	$0xa, %rcx, %rcx
               	addq	%rcx, %rax
               	addq	%rdx, %rax
               	popq	%rbx
               	leave
               	retq

<dead>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%rbx, %rax
               	movq	$0x1, %rdi
               	movq	$0x2, %rsi
               	addq	$0x5, %rax
               	popq	%rbx
               	leave
               	retq

<dead_bound>:
               	leaq	0x3(%rdi), %rax
               	movq	$0x7, %r10
               	retq

<cas>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movq	(%rsi), %rax
               	movq	%rdi, %rcx
               	lock
               	cmpxchgq	%rdx, (%rcx)
               	sete	%bl
               	movzbq	%bl, %rbx
               	movq	%rax, %rcx
               	movq	%rbx, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movq	%rcx, (%rsi)
               	popq	%rbx
               	leave
               	retq

<sumdiff>:
               	movq	%rdi, %r10
               	movq	%rsi, %r11
               	leaq	(%r10,%r11), %rax
               	subq	%r11, %r10
               	movq	%r10, %rcx
               	imulq	$0x64, %rax, %rax
               	addq	%rcx, %rax
               	retq

<sink>:
               	leaq	0x1(%rdi), %rax
               	retq

<across>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%r8, %r15
               	movq	%rcx, %r14
               	movq	%rdx, %r13
               	movq	%rsi, %r12
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, 0x38(%rsp)
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, 0x30(%rsp)
               	movq	%r13, %rdi
               	callq	<addr>
               	movq	%rax, %r13
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	%rax, %r14
               	movq	%r15, %rdi
               	callq	<addr>
               	movq	%rax, %r15
               	movq	%rbx, %r10
               	movq	%r12, %r11
               	leaq	(%r10,%r11), %rbx
               	subq	%r11, %r10
               	movq	%r10, %r12
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	0x38(%rsp), %rcx
               	addq	0x30(%rsp), %rcx
               	addq	%r13, %rcx
               	addq	%r14, %rcx
               	addq	%r15, %rcx
               	leaq	(%rbx,%rbx,2), %rdx
               	addq	%rdx, %rcx
               	addq	%r12, %rcx
               	addq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %rax
               	movq	(%rax), %r12
               	movq	0x8(%rax), %rbx
               	movq	0x10(%rax), %r13
               	movq	0x18(%rax), %r14
               	callq	<addr>
               	movabsq	$0x9abc12345678, %r11   # imm = 0x9ABC12345678
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movq	%r12, %rdi
               	callq	<addr>
               	xorq	$0x4d2, %rax            # imm = 0x4D2
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	$0xc, %rax
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movq	$0x5, -0x10(%rbp)
               	movq	$0x5, -0x8(%rbp)
               	leaq	-0x10(%rbp), %rdi
               	leaq	-0x8(%rbp), %rsi
               	movl	$0x9, %edx
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movq	-0x10(%rbp), %rax
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movq	$0x5, -0x8(%rbp)
               	leaq	-0x10(%rbp), %rdi
               	leaq	-0x8(%rbp), %rsi
               	movl	$0xb, %edx
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movq	-0x10(%rbp), %rax
               	cmpq	$0x9, %rax
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movq	%rbx, %rdi
               	movq	%r13, %rsi
               	callq	<addr>
               	cmpq	$0x4b2, %rax            # imm = 0x4B2
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movq	%r12, %rdi
               	movq	%r12, %r8
               	movq	%r14, %rcx
               	movq	%r13, %rdx
               	movq	%rbx, %rsi
               	callq	<addr>
               	cmpq	$0x37, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
