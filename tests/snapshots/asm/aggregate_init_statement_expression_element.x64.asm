
aggregate_init_statement_expression_element.x64:	file format elf64-x86-64

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

<opaque>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	leave
               	retq

<check_nested_aggregate>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	movq	%rdi, %rbx
               	leaq	-0x10(%rbp), %rdi
               	movq	$0x0, (%rdi)
               	movl	$0x0, 0x8(%rdi)
               	movl	%ebx, (%rdi)
               	movl	$0x7, %eax
               	movl	%eax, 0x4(%rdi)
               	leaq	0x1(%rbx), %rax
               	leaq	0x2(%rbx), %rcx
               	leaq	0x3(%rbx), %rdx
               	addq	%rcx, %rax
               	addq	%rdx, %rax
               	movl	%eax, 0x8(%rdi)
               	callq	<addr>
               	movl	(%rax), %ecx
               	cmpl	%ebx, %ecx
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	0x4(%rax), %ecx
               	xorq	$0x7, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	0x8(%rax), %ecx
               	leaq	(%rbx,%rbx,2), %rax
               	addq	$0x6, %rax
               	cmpl	%eax, %ecx
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x38, %rsp
               	pushq	%rbx
               	movl	$0x1000, %eax           # imm = 0x1000
               	movl	%eax, -0x28(%rbp)
               	movslq	-0x28(%rbp), %rbx
               	leaq	-0x20(%rbp), %rdi
               	movq	$0x0, (%rdi)
               	movl	$0x0, 0x8(%rdi)
               	movl	$0xa1b2c3d4, %eax       # imm = 0xA1B2C3D4
               	movl	%eax, (%rdi)
               	movl	$0x2, %eax
               	movl	%eax, 0x4(%rdi)
               	movl	$0x100, %eax            # imm = 0x100
               	cmpl	$0x100, %ebx            # imm = 0x100
               	jle	<addr>
               	movq	%rbx, %rax
               	addq	$0x30, %rax
               	movl	%eax, 0x8(%rdi)
               	callq	<addr>
               	movl	(%rax), %ecx
               	movl	$0xa1b2c3d4, %r11d      # imm = 0xA1B2C3D4
               	cmpl	%r11d, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	testl	%eax, %eax
               	je	<addr>
               	popq	%rbx
               	leave
               	retq
               	movl	$0x5, %eax
               	movl	%eax, -0x28(%rbp)
               	movslq	-0x28(%rbp), %rbx
               	leaq	-0x10(%rbp), %rdi
               	movq	$0x0, (%rdi)
               	movl	$0x0, 0x8(%rdi)
               	movl	%ebx, (%rdi)
               	movl	$0x15, %eax
               	movl	%eax, 0x4(%rdi)
               	movl	$0x1e, %eax
               	movl	%eax, 0x8(%rdi)
               	callq	<addr>
               	movslq	(%rax), %rcx
               	cmpl	%ebx, %ecx
               	je	<addr>
               	movl	$0x4, %eax
               	testl	%eax, %eax
               	je	<addr>
               	popq	%rbx
               	leave
               	retq
               	movl	$0x9, %eax
               	movl	%eax, -0x28(%rbp)
               	movslq	-0x28(%rbp), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	movslq	0x4(%rax), %rcx
               	cmpl	$0x15, %ecx
               	je	<addr>
               	movl	$0x5, %eax
               	jmp	<addr>
               	movslq	0x8(%rax), %rax
               	cmpl	$0x1e, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	0x4(%rax), %ecx
               	xorq	$0x2, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	movl	0x8(%rax), %ecx
               	cmpl	$0x100, %ebx            # imm = 0x100
               	jle	<addr>
               	leaq	0x30(%rbx), %rax
               	cmpl	%eax, %ecx
               	je	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0x100, %ebx            # imm = 0x100
               	jmp	<addr>
