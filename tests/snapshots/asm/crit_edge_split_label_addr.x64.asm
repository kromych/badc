
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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movl	%edi, -0x30(%rbp)
               	movl	%esi, -0x20(%rbp)
               	movl	%edx, -0x10(%rbp)
               	leaq	<rip>, %rax
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	movl	-0x30(%rbp), %eax
               	movl	-0x20(%rbp), %ecx
               	andq	$0xf, %rax
               	xorq	$0x5, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	jmp	<addr>
               	leaq	-<rip>, %rax        # <addr>
               	leaq	<rip>, %rcx
               	movq	%rax, (%rcx)
               	movq	$-0x1, %rax
               	leave
               	retq
               	movl	$0xb, -0x10(%rbp)
               	movl	-0x30(%rbp), %eax
               	movl	-0x20(%rbp), %ecx
               	andq	$0xf, %rax
               	xorq	$0x5, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rax
               	addq	$0x2, %rax
               	movl	%eax, -0x10(%rbp)
               	movslq	-0x10(%rbp), %rax
               	leave
               	retq
               	testb	$0x1, %cl
               	jne	<addr>
               	movl	-0x30(%rbp), %eax
               	movl	-0x20(%rbp), %ecx
               	andq	$0xf, %rax
               	xorq	$0x5, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	testb	$0x2, %cl
               	je	<addr>
               	jmp	<addr>

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
