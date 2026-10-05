
conditional_select.x64:	file format elf64-x86-64

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

<tern>:
               	movslq	%edi, %rdi
               	movslq	%edx, %rdx
               	movslq	%esi, %rsi
               	testq	%rdx, %rdx
               	movq	%rsi, %rax
               	cmovnel	%edi, %eax
               	retq

<min2>:
               	movslq	%edi, %rdi
               	movslq	%esi, %rsi
               	cmpl	%esi, %edi
               	movq	%rsi, %rax
               	cmovll	%edi, %eax
               	retq

<max2>:
               	movslq	%edi, %rdi
               	movslq	%esi, %rsi
               	cmpl	%esi, %edi
               	movq	%rsi, %rax
               	cmovgl	%edi, %eax
               	retq

<abs2>:
               	testq	%rdi, %rdi
               	jge	<addr>
               	negq	%rdi
               	movq	%rdi, %rax
               	retq

<ffs_i>:
               	bsfl	%edi, %eax
               	movl	$0x0, %r11d
               	leaq	0x1(%rax), %rax
               	cmovel	%r11d, %eax
               	retq

<ffs_l>:
               	bsfq	%rdi, %rax
               	movl	$0x0, %r11d
               	leaq	0x1(%rax), %rax
               	cmoveq	%r11, %rax
               	retq

<guarded>:
               	movslq	%esi, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movslq	(%rdi), %rax
               	retq
               	movl	$0x2, %eax
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x9, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rax
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
