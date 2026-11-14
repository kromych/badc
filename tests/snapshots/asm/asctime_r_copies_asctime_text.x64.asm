
asctime_r_copies_asctime_text.x64:	file format elf64-x86-64

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
               	subq	$0x60, %rsp
               	leaq	-0x38(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movq	$0x0, 0x30(%rax)
               	movl	$0x46, -0x24(%rbp)
               	movabsq	$0xf0000000d, %rax      # imm = 0xF0000000D
               	movabsq	$0xe00000004, %rcx      # imm = 0xE00000004
               	movq	%rcx, -0x20(%rbp)
               	movq	%rax, -0x30(%rbp)
               	movabsq	$0x400000005, %rax      # imm = 0x400000005
               	movq	%rax, -0x38(%rbp)
               	movq	<rip>, %rax # <addr>
               	leaq	-0x38(%rbp), %rdi
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
               	leave
               	retq
               	leaq	-0x58(%rbp), %rsi
               	movabsq	$0x7878787878787878, %rax # imm = 0x7878787878787878
               	movq	%rax, -0x58(%rbp)
               	movq	%rax, -0x50(%rbp)
               	movq	%rax, -0x48(%rbp)
               	movw	$0x7878, -0x40(%rbp)    # imm = 0x7878
               	leaq	-0x38(%rbp), %rdi
               	callq	<addr>
               	leaq	-0x58(%rbp), %rdi
               	cmpq	%rdi, %rax
               	jne	<addr>
               	leaq	<rip>, %rsi # <addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	-0x38(%rbp), %rdi
               	movl	$0xb, -0x28(%rbp)
               	movl	$0x1f, -0x2c(%rbp)
               	leaq	-0x58(%rbp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi # <addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
