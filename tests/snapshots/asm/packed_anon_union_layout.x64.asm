
packed_anon_union_layout.x64:	file format elf64-x86-64

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
               	subq	$0x1a0, %rsp            # imm = 0x1A0
               	leaq	-0x100(%rbp), %rax
               	addq	$0x80, %rax
               	leaq	-0x100(%rbp), %rcx
               	subq	%rcx, %rax
               	cmpq	$0x80, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x1a0, %rsp            # imm = 0x1A0
               	popq	%rbp
               	retq
               	leaq	-0x180(%rbp), %rdi
               	xorq	%rsi, %rsi
               	movl	$0x80, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x180(%rbp), %rax
               	movl	$0x3, %ecx
               	movl	%ecx, (%rax)
               	leaq	-0x180(%rbp), %rax
               	movl	$0x8, %ecx
               	movl	%ecx, 0x3c(%rax)
               	leaq	-0x180(%rbp), %rax
               	movl	$0x14, %ecx
               	movl	%ecx, 0x44(%rax)
               	leaq	-0x180(%rbp), %rax
               	movzbq	(%rax), %rcx
               	xorq	$0x3, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x1a0, %rsp            # imm = 0x1A0
               	popq	%rbp
               	retq
               	movzbq	0x3c(%rax), %rcx
               	xorq	$0x8, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x1a0, %rsp            # imm = 0x1A0
               	popq	%rbp
               	retq
               	movzbq	0x44(%rax), %rax
               	xorq	$0x14, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x1a0, %rsp            # imm = 0x1A0
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x1a0, %rsp            # imm = 0x1A0
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
