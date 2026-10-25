
strfmon_formats_in_the_c_locale.x64:	file format elf64-x86-64

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
               	subq	$0x68, %rsp
               	pushq	%rbx
               	leaq	-0x60(%rbp), %rdi
               	movl	$0x60, %esi
               	leaq	<rip>, %rdx
               	movabsq	$0x40934a0000000000, %rax # imm = 0x40934A0000000000
               	movabsq	$0x401c000000000000, %rcx # imm = 0x401C000000000000
               	movabsq	$0x3ff0000000000000, %r8 # imm = 0x3FF0000000000000
               	movabsq	$0x4132d68700000000, %r9 # imm = 0x4132D68700000000
               	movq	%rax, %xmm0
               	movq	%rcx, %xmm1
               	movq	%r8, %xmm2
               	movq	%r9, %xmm3
               	movb	$0x4, %al
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	<rip>, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	%rax, %rbx
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x60(%rbp), %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x60(%rbp), %rdi
               	movl	$0x4, %esi
               	leaq	<rip>, %rdx
               	movabsq	$0x40934a0000000000, %rax # imm = 0x40934A0000000000
               	movq	%rax, %xmm0
               	movb	$0x1, %al
               	callq	<addr>
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
