
printf_sharp_flag_leaves_infinity_and_nan_alone.x64:	file format elf64-x86-64

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
               	subq	$0x180, %rsp            # imm = 0x180
               	leaq	-0x180(%rbp), %rdi
               	movl	$0x80, %esi
               	leaq	<rip>, %rdx
               	movsd	<rip>, %xmm0
               	movsd	<rip>, %xmm1
               	movss	<rip>, %xmm2
               	cvtss2sd	%xmm2, %xmm2
               	movsd	<rip>, %xmm3
               	movl	$0x7, %ecx
               	movl	$0xff, %r8d
               	leaq	<rip>, %r9
               	movapd	%xmm0, %xmm4
               	movapd	%xmm3, %xmm5
               	movapd	%xmm1, %xmm3
               	movb	$0x6, %al
               	callq	<addr>
               	leaq	-0x180(%rbp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	-0x100(%rbp), %rdi
               	movl	$0x40, %esi
               	leaq	<rip>, %rdx
               	movsd	<rip>, %xmm0
               	movsd	<rip>, %xmm1
               	movsd	<rip>, %xmm2
               	movb	$0x3, %al
               	callq	<addr>
               	leaq	-0x100(%rbp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x2, %ecx
               	xorl	%edx, %edx
               	testq	%rax, %rax
               	cmoveq	%rdx, %rcx
               	movq	%rcx, %rax
               	leave
               	retq
