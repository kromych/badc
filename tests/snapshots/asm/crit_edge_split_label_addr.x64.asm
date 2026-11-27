
crit_edge_split_label_addr.x64:	file format elf64-x86-64

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

<probe>:
               	movl	$0xa, %eax
               	cmpl	$0x0, <rip> # <addr>
               	je	<addr>
               	leaq	-<rip>, %rax # <addr>
               	movq	%rax, <rip> # <addr>
               	movq	$-0x1, %rax
               	retq
               	andq	$0xf, %rdi
               	xorq	$0x5, %rdi
               	testl	%edi, %edi
               	jne	<addr>
               	testb	$0x1, %sil
               	je	<addr>
               	movl	$0xb, %eax
               	testl	%edi, %edi
               	jne	<addr>
               	testb	$0x2, %sil
               	je	<addr>
               	addq	$0x2, %rax
               	retq

<main>:
               	pushq	%rax
               	movl	$0x5, %edi
               	movl	$0x3, %esi
               	movl	$0xa, %edx
               	callq	<addr>
               	cmpl	$0xd, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%r11
               	retq
               	movl	$0x5, %edi
               	movl	$0x2, %esi
               	movl	$0xa, %edx
               	callq	<addr>
               	cmpl	$0xc, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%r11
               	retq
               	movl	$0x4, %edi
               	movl	$0x3, %esi
               	movl	$0xa, %edx
               	callq	<addr>
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%r11
               	retq
               	movl	$0x4, %edi
               	xorl	%esi, %esi
               	movl	$0xa, %edx
               	callq	<addr>
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%r11
               	retq
               	movl	$0x1, <rip> # <addr>
               	movl	$0x5, %edi
               	movl	$0x3, %esi
               	movl	$0xa, %edx
               	callq	<addr>
               	cmpl	$-0x1, %eax
               	jne	<addr>
               	cmpq	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	$0x5, %eax
               	popq	%r11
               	retq
               	xorl	%eax, %eax
               	popq	%r11
               	retq
