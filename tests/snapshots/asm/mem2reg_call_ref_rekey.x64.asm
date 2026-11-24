
mem2reg_call_ref_rekey.x64:	file format elf64-x86-64

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

<first>:
               	leaq	0x1(%rdi), %rax
               	retq

<f>:
               	movl	$0x1, %eax
               	movl	$0x2, %ecx
               	testl	%edi, %edi
               	movq	%rcx, %rdi
               	cmovneq	%rax, %rdi
               	jmp	<addr>

<main>:
               	pushq	%rax
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%r11
               	retq
               	xorl	%edi, %edi
               	callq	<addr>
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%r11
               	retq
               	xorl	%eax, %eax
               	popq	%r11
               	retq
