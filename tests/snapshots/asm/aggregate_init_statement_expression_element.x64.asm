
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
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<check_nested_aggregate>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%rdi, %rbx
               	leaq	-0x20(%rbp), %rdi
               	xorq	%rax, %rax
               	movq	%rax, (%rdi)
               	movl	%eax, 0x8(%rdi)
               	movl	%ebx, (%rdi)
               	movl	$0x7, %eax
               	movl	%eax, 0x4(%rdi)
               	leaq	0x1(%rbx), %rax
               	leaq	0x2(%rbx), %rcx
               	leaq	0x3(%rbx), %rdx
               	movl	%eax, %eax
               	movl	%ecx, %ecx
               	addq	%rcx, %rax
               	movl	%eax, %eax
               	movl	%edx, %ecx
               	addq	%rcx, %rax
               	movl	%eax, %eax
               	movl	%eax, 0x8(%rdi)
               	callq	<addr>
               	movl	(%rax), %ecx
               	movl	%ebx, %edx
               	cmpl	%edx, %ecx
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	0x4(%rax), %ecx
               	xorq	$0x7, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	0x8(%rax), %ecx
               	leaq	(%rbx,%rbx,2), %rax
               	addq	$0x6, %rax
               	movl	%eax, %eax
               	cmpl	%eax, %ecx
               	je	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0x1000, %eax           # imm = 0x1000
               	movl	%eax, -0x28(%rbp)
               	movslq	-0x28(%rbp), %rbx
               	leaq	-0x20(%rbp), %rdi
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rdi)
               	movl	%ecx, 0x8(%rdi)
               	movl	$0xa1b2c3d4, %ecx       # imm = 0xA1B2C3D4
               	movl	%ecx, (%rdi)
               	movl	$0x2, %ecx
               	movl	%ecx, 0x4(%rdi)
               	movl	$0x100, %ecx            # imm = 0x100
               	cmpl	$0x100, %ebx            # imm = 0x100
               	jle	<addr>
               	movq	%rbx, %rcx
               	leaq	0x30(%rcx), %rax
               	movl	%eax, 0x8(%rdi)
               	callq	<addr>
               	movl	(%rax), %ecx
               	movl	$0xa1b2c3d4, %r11d      # imm = 0xA1B2C3D4
               	cmpl	%r11d, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x5, %eax
               	movl	%eax, -0x28(%rbp)
               	movslq	-0x28(%rbp), %rbx
               	leaq	-0x10(%rbp), %rdi
               	xorq	%rax, %rax
               	movq	%rax, (%rdi)
               	movl	%eax, 0x8(%rdi)
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
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x9, %eax
               	movl	%eax, -0x28(%rbp)
               	movslq	-0x28(%rbp), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
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
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	0x4(%rax), %ecx
               	xorq	$0x2, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	movl	0x8(%rax), %eax
               	cmpl	$0x100, %ebx            # imm = 0x100
               	jle	<addr>
               	movl	%ebx, %ecx
               	addq	$0x30, %rcx
               	movl	%ecx, %ecx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	$0x100, %ebx            # imm = 0x100
               	jmp	<addr>
               	jmp	<addr>
