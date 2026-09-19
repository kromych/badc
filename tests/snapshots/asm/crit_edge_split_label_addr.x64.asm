
crit_edge_split_label_addr.x64:	file format elf64-x86-64

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

<probe>:
               	movl	$0xa, %eax
               	leaq	<rip>, %rcx
               	cmpl	$0x0, (%rcx)
               	je	<addr>
               	leaq	-<rip>, %rax        # <addr>
               	leaq	<rip>, %rcx
               	movq	%rax, (%rcx)
               	movq	$-0x1, %rax
               	retq
               	movq	%rdi, %rcx
               	andq	$0xf, %rcx
               	xorq	$0x5, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	testb	$0x1, %sil
               	je	<addr>
               	movl	$0xb, %eax
               	testl	%ecx, %ecx
               	jne	<addr>
               	testb	$0x2, %sil
               	je	<addr>
               	addq	$0x2, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x5, %edi
               	movl	$0x3, %esi
               	movl	$0xa, %edx
               	callq	<addr>
               	cmpq	$0xd, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movl	$0x5, %edi
               	movl	$0x2, %esi
               	movl	$0xa, %edx
               	callq	<addr>
               	cmpq	$0xc, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movl	$0x4, %edi
               	movl	$0x3, %esi
               	movl	$0xa, %edx
               	callq	<addr>
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movl	$0x4, %edi
               	xorl	%esi, %esi
               	movl	$0xa, %edx
               	callq	<addr>
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movl	$0x1, (%rax)
               	movl	$0x5, %edi
               	movl	$0x3, %esi
               	movl	$0xa, %edx
               	callq	<addr>
               	cmpq	$-0x1, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	cmpq	$0x0, (%rax)
               	jne	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
