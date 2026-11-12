
dynamic_frame_return_restores.x64:	file format elf64-x86-64

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

<touch>:
               	movb	%sil, (%rdi)
               	retq

<vla_plain>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rax
               	subq	%r11, %rax
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%rax, %rsp
               	cmpq	$0x9, %rdi
               	jle	<addr>
               	movl	$0x1, %esi
               	movq	%rax, %rdi
               	callq	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	$0x2, %esi
               	movq	%rax, %rdi
               	callq	<addr>
               	movl	$0x2, %eax
               	leave
               	retq

<realigned_plain>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	andq	$-0x40, %rsp
               	leaq	(%rsp), %rdi
               	movl	$0x3, %esi
               	callq	<addr>
               	leaq	(%rsp), %rax
               	testb	$0x3f, %al
               	movl	$0x3, %ecx
               	movl	$0x64, %edx
               	movq	%rcx, %rax
               	cmovneq	%rdx, %rax
               	leave
               	retq

<vla_saves>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x28, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%rbx, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %r12
               	subq	%r11, %r12
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%r12, %rsp
               	leaq	(%rbx,%rbx,2), %r13
               	leaq	(%rbx,%rbx,4), %r10
               	movq	%r10, -0x18(%rbp)
               	movl	$0x4, %esi
               	movq	%r12, %rdi
               	callq	<addr>
               	cmpq	$0x7, %rbx
               	jne	<addr>
               	movsbq	(%r12), %rax
               	addq	%r13, %rax
               	leaq	-0x40(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x5, %esi
               	movq	%r12, %rdi
               	callq	<addr>
               	imulq	-0x18(%rbp), %r13
               	movsbq	(%r12), %rax
               	addq	%r13, %rax
               	leaq	-0x40(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq

<realigned_saves>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x40, %rsp
               	andq	$-0x40, %rsp
               	imulq	$0x7, %rdi, %rbx
               	imulq	$0xb, %rdi, %r12
               	leaq	(%rsp), %rdi
               	movl	$0x6, %esi
               	callq	<addr>
               	leaq	(%rbx,%r12), %rax
               	leaq	(%rsp), %rcx
               	movsbq	(%rsp), %rdx
               	addq	%rdx, %rax
               	andq	$0x3f, %rcx
               	xorl	%edx, %edx
               	movl	$0x3e8, %esi            # imm = 0x3E8
               	testl	%ecx, %ecx
               	movq	%rdx, %rcx
               	cmovneq	%rsi, %rcx
               	addq	%rcx, %rax
               	leaq	-0x10(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq

<far_alloca>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x58, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%rbx, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %r12
               	subq	%r11, %r12
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%r12, %rsp
               	leaq	(%rbx,%rbx,2), %r13
               	leaq	(%rbx,%rbx,4), %r14
               	imulq	$0x7, %rbx, %r15
               	imulq	$0xb, %rbx, %r10
               	movq	%r10, -0x1018(%rbp)
               	imulq	$0xd, %rbx, %r10
               	movq	%r10, -0x1020(%rbp)
               	imulq	$0x11, %rbx, %r10
               	movq	%r10, -0x1028(%rbp)
               	imulq	$0x13, %rbx, %r10
               	movq	%r10, -0x1030(%rbp)
               	imulq	$0x17, %rbx, %r10
               	movq	%r10, -0x1038(%rbp)
               	imulq	$0x1d, %rbx, %r10
               	movq	%r10, -0x1040(%rbp)
               	imulq	$0x1f, %rbx, %r10
               	movq	%r10, -0x1048(%rbp)
               	movb	$0x1, -0x1000(%rbp)
               	movl	$0x7, %esi
               	movq	%r12, %rdi
               	callq	<addr>
               	cmpq	$0x5, %rbx
               	jne	<addr>
               	leaq	(%r13,%r14), %rax
               	addq	%r15, %rax
               	addq	-0x1018(%rbp), %rax
               	addq	-0x1020(%rbp), %rax
               	movsbq	-0x1000(%rbp), %rcx
               	addq	%rcx, %rax
               	movsbq	(%r12), %rcx
               	addq	%rcx, %rax
               	leaq	-0x1080(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	-0x1000(%rbp), %rdi
               	movl	$0x1, %esi
               	callq	<addr>
               	imulq	%r14, %r13
               	imulq	-0x1018(%rbp), %r15
               	leaq	(%r13,%r15), %rax
               	movq	-0x1020(%rbp), %rcx
               	imulq	-0x1028(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x1030(%rbp), %rcx
               	imulq	-0x1038(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x1040(%rbp), %rcx
               	imulq	-0x1048(%rbp), %rcx
               	addq	%rcx, %rax
               	movsbq	-0x1000(%rbp), %rcx
               	addq	%rcx, %rax
               	movsbq	(%r12), %rcx
               	addq	%rcx, %rax
               	leaq	-0x1080(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<folded_far>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x158, %rsp            # imm = 0x158
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%rbx, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %r12
               	subq	%r11, %r12
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%r12, %rsp
               	leaq	(%rbx,%rbx,2), %r13
               	leaq	(%rbx,%rbx,4), %r10
               	movq	%r10, -0x148(%rbp)
               	movb	$0x1, -0x130(%rbp)
               	movb	$0x2, -0x12f(%rbp)
               	movl	$0x7, %esi
               	movq	%r12, %rdi
               	callq	<addr>
               	leaq	-0x130(%rbp), %rdi
               	movl	$0x9, %esi
               	callq	<addr>
               	cmpq	$0x4, %rbx
               	jne	<addr>
               	movsbq	-0x130(%rbp), %rax
               	addq	%r13, %rax
               	movsbq	-0x12f(%rbp), %rcx
               	addq	%rcx, %rax
               	movsbq	(%r12), %rcx
               	addq	%rcx, %rax
               	leaq	-0x170(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	-0x130(%rbp), %rax
               	leaq	0x1(%rax), %rdi
               	movl	$0x3, %esi
               	callq	<addr>
               	imulq	-0x148(%rbp), %r13
               	movsbq	-0x130(%rbp), %rax
               	addq	%r13, %rax
               	movsbq	-0x12f(%rbp), %rcx
               	addq	%rcx, %rax
               	movsbq	(%r12), %rcx
               	addq	%rcx, %rax
               	leaq	-0x170(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x58, %rsp
               	pushq	%rbx
               	movq	<rip>, %rbx # <addr>
               	movq	<rip>, %rax # <addr>
               	movq	%rbx, %r10
               	imulq	%rax, %r10
               	movq	%r10, 0x58(%rsp)
               	movq	<rip>, %rax # <addr>
               	movq	%rbx, %r10
               	imulq	%rax, %r10
               	movq	%r10, 0x50(%rsp)
               	movq	<rip>, %rax # <addr>
               	movq	%rbx, %r10
               	imulq	%rax, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	<rip>, %rax # <addr>
               	movq	%rbx, %r10
               	imulq	%rax, %r10
               	movq	%r10, 0x40(%rsp)
               	movq	<rip>, %rax # <addr>
               	movq	%rbx, %r10
               	imulq	%rax, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	<rip>, %rax # <addr>
               	movq	%rbx, %r10
               	imulq	%rax, %r10
               	movq	%r10, 0x30(%rsp)
               	movq	<rip>, %rax # <addr>
               	movq	%rbx, %r10
               	imulq	%rax, %r10
               	movq	%r10, 0x28(%rsp)
               	movq	<rip>, %rax # <addr>
               	movq	%rbx, %r10
               	imulq	%rax, %r10
               	movq	%r10, 0x20(%rsp)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, 0x18(%rsp)
               	leaq	0x5(%rbx), %rdi
               	callq	<addr>
               	movq	0x18(%rsp), %r10
               	addq	%rax, %r10
               	movq	%r10, 0x18(%rsp)
               	callq	<addr>
               	movq	0x18(%rsp), %r10
               	addq	%rax, %r10
               	movq	%r10, 0x18(%rsp)
               	leaq	0x1(%rbx), %rdi
               	callq	<addr>
               	movq	0x18(%rsp), %r10
               	addq	%rax, %r10
               	movq	%r10, 0x18(%rsp)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	0x18(%rsp), %r10
               	addq	%rax, %r10
               	movq	%r10, 0x18(%rsp)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	0x18(%rsp), %r10
               	addq	%rax, %r10
               	movq	%r10, 0x18(%rsp)
               	leaq	-0x1(%rbx), %rdi
               	callq	<addr>
               	movq	0x18(%rsp), %r10
               	addq	%rax, %r10
               	movq	%r10, 0x18(%rsp)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	0x18(%rsp), %r10
               	addq	%rax, %r10
               	movq	%r10, 0x18(%rsp)
               	leaq	-0x1(%rbx), %rdi
               	callq	<addr>
               	movq	0x18(%rsp), %r10
               	addq	%rax, %r10
               	movq	%r10, 0x18(%rsp)
               	leaq	-0x2(%rbx), %rdi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	0x18(%rsp), %rax
               	addq	%r10, %rax
               	movq	<rip>, %rcx # <addr>
               	imulq	%rbx, %rcx
               	movq	%rcx, %r10
               	movq	0x58(%rsp), %rcx
               	cmpq	%r10, %rcx
               	jne	<addr>
               	movq	<rip>, %rcx # <addr>
               	imulq	%rbx, %rcx
               	movq	%rcx, %r10
               	movq	0x50(%rsp), %rcx
               	cmpq	%r10, %rcx
               	jne	<addr>
               	movq	<rip>, %rcx # <addr>
               	imulq	%rbx, %rcx
               	movq	%rcx, %r10
               	movq	0x48(%rsp), %rcx
               	cmpq	%r10, %rcx
               	jne	<addr>
               	movq	<rip>, %rcx # <addr>
               	imulq	%rbx, %rcx
               	movq	%rcx, %r10
               	movq	0x40(%rsp), %rcx
               	cmpq	%r10, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	<rip>, %rcx # <addr>
               	imulq	%rbx, %rcx
               	movq	%rcx, %r10
               	movq	0x38(%rsp), %rcx
               	cmpq	%r10, %rcx
               	jne	<addr>
               	movq	<rip>, %rcx # <addr>
               	imulq	%rbx, %rcx
               	movq	%rcx, %r10
               	movq	0x30(%rsp), %rcx
               	cmpq	%r10, %rcx
               	jne	<addr>
               	movq	<rip>, %rcx # <addr>
               	imulq	%rbx, %rcx
               	movq	%rcx, %r10
               	movq	0x28(%rsp), %rcx
               	cmpq	%r10, %rcx
               	jne	<addr>
               	movq	<rip>, %rcx # <addr>
               	imulq	%rbx, %rcx
               	movq	%rcx, %r10
               	movq	0x20(%rsp), %rcx
               	cmpq	%r10, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%ecx, %ecx
               	movl	$0x3, %edx
               	cmpq	$0xed11, %rax           # imm = 0xED11
               	movq	%rdx, %rax
               	cmoveq	%rcx, %rax
               	popq	%rbx
               	leave
               	retq
