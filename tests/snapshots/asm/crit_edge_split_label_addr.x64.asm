
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
               	movq	%rdi, -0x30(%rbp)
               	movq	%rsi, -0x20(%rbp)
               	movq	%rdx, -0x10(%rbp)
               	movq	%rdi, -0x30(%rbp)
               	movq	%rsi, -0x20(%rbp)
               	movl	%edx, -0x10(%rbp)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	jmp	<addr>
               	movl	-0x30(%rbp), %eax
               	movl	-0x20(%rbp), %edx
               	jmp	<addr>
               	testq	%rcx, %rcx
               	je	<addr>
               	jmp	<addr>
               	leaq	-<rip>, %rax        # <addr>
               	leaq	<rip>, %rcx
               	movq	%rax, (%rcx)
               	movabsq	$-0x1, %rax
               	leave
               	retq
               	movslq	-0x10(%rbp), %rcx
               	incq	%rcx
               	movl	%ecx, -0x10(%rbp)
               	movl	-0x30(%rbp), %ecx
               	movl	-0x20(%rbp), %edx
               	jmp	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	-0x10(%rbp), %rax
               	addq	$0x2, %rax
               	movl	%eax, -0x10(%rbp)
               	movslq	-0x10(%rbp), %rax
               	leave
               	retq
               	movl	%eax, %eax
               	andq	$0xf, %rax
               	xorq	$0x5, %rax
               	movl	%eax, %ecx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	%edx, %ecx
               	andq	$0x1, %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	jmp	<addr>
               	movl	%ecx, %ecx
               	andq	$0xf, %rcx
               	xorq	$0x5, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	%edx, %eax
               	andq	$0x2, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
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
               	xorq	%rsi, %rsi
               	movl	$0xa, %edx
               	callq	<addr>
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movl	%ecx, (%rax)
               	movl	$0x5, %edi
               	movl	$0x3, %esi
               	movl	$0xa, %edx
               	callq	<addr>
               	cmpq	$-0x1, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
