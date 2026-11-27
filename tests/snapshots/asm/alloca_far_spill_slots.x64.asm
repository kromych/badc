
alloca_far_spill_slots.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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

<touch>:
               	movb	$0x1, (%rdi)
               	movb	$0x2, (%rsi)
               	retq

<f>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x78, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rbx
               	subq	%r11, %rbx
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%rbx, %rsp
               	leaq	(%rdi,%rdi,2), %r12
               	leaq	(%rdi,%rdi,4), %r13
               	imulq	$0x7, %rdi, %r14
               	imulq	$0xb, %rdi, %r15
               	imulq	$0xd, %rdi, %r10
               	movq	%r10, -0x1018(%rbp)
               	imulq	$0x11, %rdi, %r10
               	movq	%r10, -0x1020(%rbp)
               	imulq	$0x13, %rdi, %r10
               	movq	%r10, -0x1028(%rbp)
               	imulq	$0x17, %rdi, %r10
               	movq	%r10, -0x1030(%rbp)
               	imulq	$0x1d, %rdi, %r10
               	movq	%r10, -0x1038(%rbp)
               	imulq	$0x1f, %rdi, %r10
               	movq	%r10, -0x1040(%rbp)
               	imulq	$0x25, %rdi, %r10
               	movq	%r10, -0x1048(%rbp)
               	imulq	$0x29, %rdi, %r10
               	movq	%r10, -0x1050(%rbp)
               	imulq	$0x2b, %rdi, %r10
               	movq	%r10, -0x1058(%rbp)
               	imulq	$0x2f, %rdi, %r10
               	movq	%r10, -0x1060(%rbp)
               	imulq	$0x35, %rdi, %r10
               	movq	%r10, -0x1068(%rbp)
               	movq	%rbx, %rsi
               	leaq	-0x1008(%rbp), %rdi
               	callq	<addr>
               	leaq	(%r12,%r13), %rax
               	addq	%r14, %rax
               	addq	%r15, %rax
               	addq	-0x1018(%rbp), %rax
               	addq	-0x1020(%rbp), %rax
               	addq	-0x1028(%rbp), %rax
               	addq	-0x1030(%rbp), %rax
               	addq	-0x1038(%rbp), %rax
               	addq	-0x1040(%rbp), %rax
               	addq	-0x1048(%rbp), %rax
               	addq	-0x1050(%rbp), %rax
               	addq	-0x1058(%rbp), %rax
               	addq	-0x1060(%rbp), %rax
               	movq	%rax, %r10
               	addq	-0x1068(%rbp), %r10
               	movq	%r10, -0x1070(%rbp)
               	movq	%rbx, %rsi
               	leaq	-0x1008(%rbp), %rdi
               	callq	<addr>
               	imulq	%r13, %r12
               	imulq	%r15, %r14
               	leaq	(%r12,%r14), %rax
               	movq	-0x1018(%rbp), %rcx
               	imulq	-0x1020(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x1028(%rbp), %rcx
               	imulq	-0x1030(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x1038(%rbp), %rcx
               	imulq	-0x1040(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x1048(%rbp), %rcx
               	imulq	-0x1050(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x1058(%rbp), %rcx
               	imulq	-0x1060(%rbp), %rcx
               	addq	%rcx, %rax
               	addq	-0x1068(%rbp), %rax
               	movq	%rax, %r10
               	movq	-0x1070(%rbp), %rax
               	addq	%r10, %rax
               	movsbq	-0x1008(%rbp), %rcx
               	addq	%rcx, %rax
               	movsbq	(%rbx), %rcx
               	addq	%rcx, %rax
               	leaq	-0x10a0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<expect>:
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	(%rdi,%rdi,2), %rax
               	leaq	(%rdi,%rdi,4), %r9
               	leaq	(%rax,%r9), %rdx
               	imulq	$0x7, %rdi, %rcx
               	addq	%rcx, %rdx
               	imulq	$0xb, %rdi, %r10
               	leaq	(%rdx,%r10), %rsi
               	imulq	$0xd, %rdi, %rdx
               	addq	%rdx, %rsi
               	imulq	$0x11, %rdi, %r11
               	leaq	(%rsi,%r11), %r8
               	imulq	$0x13, %rdi, %rsi
               	addq	%rsi, %r8
               	imulq	$0x17, %rdi, %rbx
               	leaq	(%r8,%rbx), %r12
               	imulq	$0x1d, %rdi, %r8
               	leaq	(%r12,%r8), %r13
               	imulq	$0x1f, %rdi, %r12
               	addq	%r12, %r13
               	imulq	$0x25, %rdi, %r14
               	addq	%r14, %r13
               	imulq	$0x29, %rdi, %r14
               	addq	%r14, %r13
               	imulq	$0x2b, %rdi, %r14
               	addq	%r14, %r13
               	imulq	$0x2f, %rdi, %r14
               	addq	%r14, %r13
               	imulq	$0x35, %rdi, %r14
               	addq	%r14, %r13
               	imulq	%r9, %rax
               	addq	%r13, %rax
               	imulq	%r10, %rcx
               	addq	%rcx, %rax
               	imulq	%r11, %rdx
               	addq	%rdx, %rax
               	imulq	%rbx, %rsi
               	addq	%rsi, %rax
               	imulq	%r12, %r8
               	leaq	(%rax,%r8), %rcx
               	imulq	$0x25, %rdi, %rax
               	imulq	$0x29, %rdi, %rdx
               	imulq	%rdx, %rax
               	addq	%rax, %rcx
               	imulq	$0x2b, %rdi, %rax
               	imulq	$0x2f, %rdi, %rdx
               	imulq	%rdx, %rax
               	addq	%rcx, %rax
               	imulq	$0x35, %rdi, %rcx
               	addq	%rcx, %rax
               	addq	$0x3, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	retq

<main>:
               	pushq	%rbx
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	movl	$0x2, %edi
               	callq	<addr>
               	cmpq	%rax, %rbx
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	retq
               	movl	$0x9, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	movl	$0x9, %edi
               	callq	<addr>
               	cmpq	%rax, %rbx
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	retq
