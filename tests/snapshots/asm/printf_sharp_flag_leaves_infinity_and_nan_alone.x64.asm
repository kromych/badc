
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
               	pushq	%r12
               	pushq	%rbx
               	leaq	-0x180(%rbp), %rdi
               	movl	$0x80, %esi
               	leaq	<rip>, %rdx
               	movabsq	$0x7ff0000000000000, %rax # imm = 0x7FF0000000000000
               	movabsq	$-0x10000000000000, %rcx # imm = 0xFFF0000000000000
               	movl	$0x7fc00000, %r8d       # imm = 0x7FC00000
               	movq	%r8, %xmm14
               	cvtss2sd	%xmm14, %xmm0
               	movabsq	$0x3ff0000000000000, %r8 # imm = 0x3FF0000000000000
               	movl	$0x7, %r9d
               	movl	$0xff, %ebx
               	leaq	<rip>, %r12
               	movapd	%xmm0, %xmm2
               	movq	%rax, %xmm0
               	movq	%rcx, %xmm1
               	movq	%rcx, %xmm3
               	movq	%rax, %xmm4
               	movq	%r8, %xmm5
               	movq	%r9, %rcx
               	movq	%r12, %r9
               	movq	%rbx, %r8
               	movb	$0x6, %al
               	callq	<addr>
               	leaq	-0x180(%rbp), %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x100(%rbp), %rdi
               	movl	$0x40, %esi
               	leaq	<rip>, %rdx
               	movabsq	$-0x10000000000000, %rax # imm = 0xFFF0000000000000
               	movabsq	$0x7ff0000000000000, %rcx # imm = 0x7FF0000000000000
               	movabsq	$0x3ff8000000000000, %r8 # imm = 0x3FF8000000000000
               	movq	%rax, %xmm0
               	movq	%rcx, %xmm1
               	movq	%r8, %xmm2
               	movb	$0x3, %al
               	callq	<addr>
               	leaq	-0x100(%rbp), %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x2, %ecx
               	xorl	%edx, %edx
               	testq	%rax, %rax
               	movq	%rdx, %rax
               	cmovneq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
