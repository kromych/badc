
aggregate_init_statement_expression_element.x64:	file format elf64-x86-64

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

<opaque>:
               	subq	$0x18, %rsp
               	movq	%rdi, 0x8(%rsp)
               	movq	0x8(%rsp), %rax
               	addq	$0x18, %rsp
               	retq

<main>:
               	subq	$0x30, %rsp
               	pushq	%rbx
               	movl	$0x1000, 0x28(%rsp)     # imm = 0x1000
               	movslq	0x28(%rsp), %rbx
               	leaq	0x18(%rsp), %rdi
               	movabsq	$0x2a1b2c3d4, %rax      # imm = 0x2A1B2C3D4
               	movq	%rax, 0x18(%rsp)
               	movl	$0x100, %eax            # imm = 0x100
               	cmpl	$0x100, %ebx            # imm = 0x100
               	cmovgq	%rbx, %rax
               	addq	$0x30, %rax
               	movl	%eax, 0x20(%rsp)
               	callq	<addr>
               	movl	(%rax), %ecx
               	cmpl	$0xa1b2c3d4, %ecx       # imm = 0xA1B2C3D4
               	je	<addr>
               	movl	$0x1, %eax
               	testl	%eax, %eax
               	je	<addr>
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	movl	$0x5, 0x28(%rsp)
               	movl	0x28(%rsp), %ebx
               	leaq	0x18(%rsp), %rdi
               	movl	%ebx, 0x18(%rsp)
               	movl	$0x15, 0x1c(%rsp)
               	movl	$0x1e, 0x20(%rsp)
               	callq	<addr>
               	movl	(%rax), %ecx
               	cmpl	%ebx, %ecx
               	je	<addr>
               	movl	$0x4, %eax
               	testl	%eax, %eax
               	je	<addr>
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	movl	$0x9, 0x28(%rsp)
               	movl	0x28(%rsp), %ebx
               	leaq	0x18(%rsp), %rdi
               	movl	%ebx, 0x18(%rsp)
               	movl	$0x7, 0x1c(%rsp)
               	leaq	0x1(%rbx), %rax
               	leaq	0x2(%rbx), %rcx
               	leaq	0x3(%rbx), %rdx
               	addq	%rcx, %rax
               	addq	%rdx, %rax
               	movl	%eax, 0x20(%rsp)
               	callq	<addr>
               	movl	(%rax), %ecx
               	cmpl	%ebx, %ecx
               	je	<addr>
               	movl	$0x7, %eax
               	testl	%eax, %eax
               	je	<addr>
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	addq	$0x30, %rsp
               	retq
               	movl	0x4(%rax), %ecx
               	cmpl	$0x7, %ecx
               	je	<addr>
               	movl	$0x8, %eax
               	jmp	<addr>
               	movl	0x8(%rax), %eax
               	leaq	(%rbx,%rbx,2), %rcx
               	addq	$0x6, %rcx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	0x4(%rax), %ecx
               	cmpl	$0x15, %ecx
               	je	<addr>
               	movl	$0x5, %eax
               	jmp	<addr>
               	movl	0x8(%rax), %eax
               	cmpl	$0x1e, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	0x4(%rax), %ecx
               	cmpl	$0x2, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	movl	0x8(%rax), %eax
               	movl	$0x100, %ecx            # imm = 0x100
               	cmpl	$0x100, %ebx            # imm = 0x100
               	cmovgq	%rbx, %rcx
               	addq	$0x30, %rcx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
