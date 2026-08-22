
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
               	movslq	%ebx, %rbx
               	leaq	-0x20(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movl	%ecx, 0x8(%rax)
               	leaq	-0x20(%rbp), %rax
               	movl	%ebx, (%rax)
               	movl	$0x7, %ecx
               	leaq	-0x20(%rbp), %rax
               	movl	%ecx, 0x4(%rax)
               	leaq	0x1(%rbx), %rax
               	leaq	0x2(%rbx), %rcx
               	leaq	0x3(%rbx), %rdx
               	movl	%eax, %eax
               	movl	%ecx, %ecx
               	addq	%rcx, %rax
               	movl	%eax, %eax
               	movl	%edx, %ecx
               	addq	%rcx, %rax
               	movl	%eax, %ecx
               	leaq	-0x20(%rbp), %rax
               	movl	%ecx, 0x8(%rax)
               	leaq	-0x20(%rbp), %rdi
               	callq	<addr>
               	movl	(%rax), %ecx
               	movl	%ebx, %edx
               	cmpq	%rdx, %rcx
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
               	movslq	%eax, %rax
               	movl	%eax, %eax
               	cmpq	%rax, %rcx
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
               	leaq	-0x20(%rbp), %rax
               	xorq	%rdx, %rdx
               	movq	%rdx, (%rax)
               	movl	%edx, 0x8(%rax)
               	movl	$0xa1b2c3d4, %eax       # imm = 0xA1B2C3D4
               	leaq	-0x20(%rbp), %rdx
               	movl	%eax, (%rdx)
               	movl	$0x2, %edx
               	leaq	-0x20(%rbp), %rax
               	movl	%edx, 0x4(%rax)
               	movl	$0x100, %eax            # imm = 0x100
               	cmpq	$0x100, %rbx            # imm = 0x100
               	jle	<addr>
               	movq	%rbx, %rax
               	addq	$0x30, %rax
               	leaq	-0x20(%rbp), %rcx
               	movl	%eax, 0x8(%rcx)
               	leaq	-0x20(%rbp), %rdi
               	callq	<addr>
               	movl	(%rax), %ecx
               	movl	$0xa1b2c3d4, %r11d      # imm = 0xA1B2C3D4
               	cmpq	%r11, %rcx
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
               	leaq	-0x10(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movl	%ecx, 0x8(%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	%ebx, (%rax)
               	movl	$0x15, %ecx
               	leaq	-0x10(%rbp), %rax
               	movl	%ecx, 0x4(%rax)
               	movl	$0x1e, %ecx
               	leaq	-0x10(%rbp), %rax
               	movl	%ecx, 0x8(%rax)
               	leaq	-0x10(%rbp), %rdi
               	callq	<addr>
               	movslq	(%rax), %rcx
               	cmpq	%rbx, %rcx
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
               	cmpq	$0x15, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	jmp	<addr>
               	movslq	0x8(%rax), %rax
               	cmpq	$0x1e, %rax
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
               	cmpq	$0x100, %rbx            # imm = 0x100
               	jle	<addr>
               	movl	%ebx, %ecx
               	addq	$0x30, %rcx
               	movl	%ecx, %ecx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	$0x100, %ebx            # imm = 0x100
               	jmp	<addr>
               	jmp	<addr>
