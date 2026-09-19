
dead_arm_config_predicate_undefined.x64:	file format elf64-x86-64

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

<dispatch>:
               	movq	(%rdi), %rcx
               	movq	%rcx, %rax
               	andq	$0x1, %rax
               	addq	$0xa, %rax
               	andq	$0x8, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x1, %ecx
               	addq	%rcx, %rax
               	retq
               	xorl	%ecx, %ecx
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	xorl	%esi, %esi
               	leaq	-0x8(%rbp), %rax
               	movq	%rsi, (%rax)
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	movq	%rcx, %rdx
               	andq	$0x1, %rdx
               	addq	$0xa, %rdx
               	movq	%rcx, %rdi
               	andq	$0x8, %rdi
               	testl	%edi, %edi
               	je	<addr>
               	addq	%rdx, %rcx
               	leaq	0xa(%rcx), %rsi
               	movl	$0x2, %edx
               	movq	%rdx, (%rax)
               	movq	%rdx, %rcx
               	andq	$0x1, %rcx
               	addq	$0xa, %rcx
               	movq	%rdx, %rax
               	andq	$0x8, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rcx, %rax
               	addq	%rax, %rsi
               	movl	$0x3, %edx
               	leaq	-0x8(%rbp), %rax
               	movq	%rdx, (%rax)
               	movq	%rdx, %rcx
               	andq	$0x1, %rcx
               	addq	$0xa, %rcx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	je	<addr>
               	movl	$0x1, %edx
               	addq	%rdx, %rcx
               	addq	%rcx, %rsi
               	movl	$0x4, %edx
               	movq	%rdx, (%rax)
               	movq	%rdx, %rcx
               	andq	$0x1, %rcx
               	addq	$0xa, %rcx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	je	<addr>
               	movl	$0x1, %edx
               	addq	%rdx, %rcx
               	addq	%rcx, %rsi
               	movl	$0x5, %edx
               	movq	%rdx, (%rax)
               	movq	%rdx, %rcx
               	andq	$0x1, %rcx
               	addq	$0xa, %rcx
               	movq	%rdx, %rax
               	andq	$0x8, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rcx, %rax
               	addq	%rax, %rsi
               	movl	$0x6, %edx
               	leaq	-0x8(%rbp), %rax
               	movq	%rdx, (%rax)
               	movq	%rdx, %rcx
               	andq	$0x1, %rcx
               	addq	$0xa, %rcx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	je	<addr>
               	movl	$0x1, %edx
               	addq	%rdx, %rcx
               	addq	%rcx, %rsi
               	movl	$0x7, %edx
               	movq	%rdx, (%rax)
               	movq	%rdx, %rcx
               	andq	$0x1, %rcx
               	addq	$0xa, %rcx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	je	<addr>
               	movl	$0x1, %edx
               	addq	%rdx, %rcx
               	addq	%rcx, %rsi
               	movl	$0x8, %edx
               	movq	%rdx, (%rax)
               	movq	%rdx, %rcx
               	andq	$0x1, %rcx
               	addq	$0xa, %rcx
               	movq	%rdx, %rax
               	andq	$0x8, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rcx, %rax
               	addq	%rax, %rsi
               	movl	$0x9, %edx
               	leaq	-0x8(%rbp), %rax
               	movq	%rdx, (%rax)
               	movq	%rdx, %rcx
               	andq	$0x1, %rcx
               	addq	$0xa, %rcx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	je	<addr>
               	movl	$0x1, %edx
               	addq	%rdx, %rcx
               	addq	%rcx, %rsi
               	movl	$0xa, %edx
               	movq	%rdx, (%rax)
               	movq	%rdx, %rcx
               	andq	$0x1, %rcx
               	addq	$0xa, %rcx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	je	<addr>
               	movl	$0x1, %edx
               	addq	%rdx, %rcx
               	addq	%rcx, %rsi
               	movl	$0xb, %edx
               	movq	%rdx, (%rax)
               	movq	%rdx, %rcx
               	andq	$0x1, %rcx
               	addq	$0xa, %rcx
               	movq	%rdx, %rax
               	andq	$0x8, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rcx, %rax
               	addq	%rax, %rsi
               	movl	$0xc, %edx
               	leaq	-0x8(%rbp), %rax
               	movq	%rdx, (%rax)
               	movq	%rdx, %rcx
               	andq	$0x1, %rcx
               	addq	$0xa, %rcx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	je	<addr>
               	movl	$0x1, %edx
               	addq	%rdx, %rcx
               	addq	%rcx, %rsi
               	movl	$0xd, %edx
               	movq	%rdx, (%rax)
               	movq	%rdx, %rcx
               	andq	$0x1, %rcx
               	addq	$0xa, %rcx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	je	<addr>
               	movl	$0x1, %edx
               	addq	%rdx, %rcx
               	addq	%rcx, %rsi
               	movl	$0xe, %edx
               	movq	%rdx, (%rax)
               	movq	%rdx, %rcx
               	andq	$0x1, %rcx
               	addq	$0xa, %rcx
               	movq	%rdx, %rax
               	andq	$0x8, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rcx, %rax
               	addq	%rax, %rsi
               	movl	$0xf, %ecx
               	leaq	-0x8(%rbp), %rdx
               	movq	%rcx, (%rdx)
               	movq	%rcx, %rax
               	andq	$0x1, %rax
               	addq	$0xa, %rax
               	andq	$0x8, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x1, %ecx
               	addq	%rcx, %rax
               	addq	%rsi, %rax
               	cmpl	$0xb0, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	movq	$0x0, (%rax)
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	xorl	%eax, %eax
               	leave
               	retq
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%edx, %edx
               	jmp	<addr>
               	xorl	%edx, %edx
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%edx, %edx
               	jmp	<addr>
               	xorl	%edx, %edx
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%edx, %edx
               	jmp	<addr>
               	xorl	%edx, %edx
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%edx, %edx
               	jmp	<addr>
               	xorl	%edx, %edx
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	%rsi, %rcx
               	jmp	<addr>
