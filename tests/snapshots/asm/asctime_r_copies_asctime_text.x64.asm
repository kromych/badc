
asctime_r_copies_asctime_text.x64:	file format elf64-x86-64

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

<main>:
               	subq	$0x68, %rsp
               	leaq	0x28(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movq	$0x0, 0x30(%rax)
               	movl	$0x46, 0x3c(%rsp)
               	movabsq	$0xf0000000d, %rax      # imm = 0xF0000000D
               	movabsq	$0xe00000004, %rcx      # imm = 0xE00000004
               	movq	%rcx, 0x40(%rsp)
               	movq	%rax, 0x30(%rsp)
               	movabsq	$0x400000005, %rax      # imm = 0x400000005
               	movq	%rax, 0x28(%rsp)
               	movq	<rip>, %rax # <addr>
               	leaq	0x28(%rsp), %rdi
               	callq	*%rax
               	movq	%rax, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	leaq	<rip>, %rsi # <addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x68, %rsp
               	retq
               	leaq	0x8(%rsp), %rsi
               	movabsq	$0x7878787878787878, %rax # imm = 0x7878787878787878
               	movq	%rax, 0x8(%rsp)
               	movq	%rax, 0x10(%rsp)
               	movq	%rax, 0x18(%rsp)
               	movw	$0x7878, 0x20(%rsp)     # imm = 0x7878
               	leaq	0x28(%rsp), %rdi
               	callq	<addr>
               	leaq	0x8(%rsp), %rdi
               	cmpq	%rdi, %rax
               	jne	<addr>
               	leaq	<rip>, %rsi # <addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x68, %rsp
               	retq
               	leaq	0x28(%rsp), %rdi
               	movl	$0xb, 0x38(%rsp)
               	movl	$0x1f, 0x34(%rsp)
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi # <addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x68, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x68, %rsp
               	retq
