
over_aligned_local_in_an_inlined_function.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	andq	$-0x40, %rsp
               	leaq	0x40(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movl	$0x0, 0x20(%rsp)
               	movl	$0x1, 0x24(%rsp)
               	movl	$0x2, 0x28(%rsp)
               	movl	$0x3, 0x2c(%rsp)
               	movl	$0x4, 0x30(%rsp)
               	movl	$0x5, 0x34(%rsp)
               	movl	$0x6, 0x38(%rsp)
               	leaq	0x20(%rsp), %rax
               	movl	$0x7, 0x3c(%rsp)
               	testb	$0x1f, %al
               	je	<addr>
               	movl	$0x3e8, %eax            # imm = 0x3E8
               	movl	0x24(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	0x28(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	0x2c(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	0x30(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	0x34(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	0x38(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	0x3c(%rsp), %ecx
               	leaq	(%rax,%rcx), %rsi
               	leaq	(%rsp), %rdi
               	xorl	%eax, %eax
               	movb	%al, (%rsp)
               	movb	$0x1, 0x1(%rsp)
               	movb	$0x2, 0x2(%rsp)
               	testb	$0x3f, %dil
               	je	<addr>
               	movl	$0x3e8, %eax            # imm = 0x3E8
               	movsbq	0x1(%rsp), %rdi
               	addq	%rdi, %rax
               	movsbq	0x2(%rsp), %rdi
               	addq	%rdi, %rax
               	addq	%rax, %rsi
               	movl	$0x1, 0x20(%rsp)
               	movl	$0x2, 0x24(%rsp)
               	movl	$0x3, 0x28(%rsp)
               	movl	$0x4, 0x2c(%rsp)
               	leaq	0x20(%rsp), %rax
               	movl	$0x5, 0x30(%rsp)
               	movl	$0x6, 0x34(%rsp)
               	movl	$0x7, 0x38(%rsp)
               	movl	$0x8, 0x3c(%rsp)
               	testb	$0x1f, %al
               	je	<addr>
               	movl	$0x3e8, %eax            # imm = 0x3E8
               	movl	0x20(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	0x24(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	0x28(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	0x2c(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	0x30(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	0x34(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	0x38(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	0x3c(%rsp), %ecx
               	leaq	(%rax,%rcx), %rdx
               	leaq	(%rsp), %rdi
               	movb	$0x1, (%rsp)
               	movb	$0x1, 0x1(%rsp)
               	movb	$0x2, 0x2(%rsp)
               	testb	$0x3f, %dil
               	je	<addr>
               	movl	$0x3e8, %eax            # imm = 0x3E8
               	movsbq	(%rsp), %rdi
               	addq	%rdi, %rax
               	movsbq	0x1(%rsp), %rdi
               	addq	%rdi, %rax
               	movsbq	0x2(%rsp), %rdi
               	addq	%rdi, %rax
               	addq	%rdx, %rax
               	leaq	(%rsi,%rax), %rdx
               	movl	$0x2, 0x20(%rsp)
               	movl	$0x3, 0x24(%rsp)
               	movl	$0x4, 0x28(%rsp)
               	movl	$0x5, 0x2c(%rsp)
               	movl	$0x6, 0x30(%rsp)
               	leaq	0x20(%rsp), %rax
               	movl	$0x7, 0x34(%rsp)
               	movl	$0x8, 0x38(%rsp)
               	movl	$0x9, 0x3c(%rsp)
               	testb	$0x1f, %al
               	je	<addr>
               	movl	$0x3e8, %eax            # imm = 0x3E8
               	movl	0x20(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	0x24(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	0x28(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	0x2c(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	0x30(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	0x34(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	0x38(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	0x3c(%rsp), %ecx
               	addq	%rax, %rcx
               	leaq	(%rsp), %rsi
               	movb	$0x2, (%rsp)
               	movb	$0x1, 0x1(%rsp)
               	movb	$0x2, 0x2(%rsp)
               	testb	$0x3f, %sil
               	je	<addr>
               	movl	$0x3e8, %eax            # imm = 0x3E8
               	movsbq	(%rsp), %rsi
               	addq	%rsi, %rax
               	movsbq	0x1(%rsp), %rsi
               	addq	%rsi, %rax
               	movsbq	0x2(%rsp), %rsi
               	addq	%rsi, %rax
               	addq	%rcx, %rax
               	addq	%rdx, %rax
               	cmpl	$0x78, %eax
               	jne	<addr>
               	leaq	0x40(%rsp), %rax
               	testb	$0xf, %al
               	jne	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
