
asm_goto_operand_region_paths.x64:	file format elf64-x86-64

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

<patched>:
               	leaq	<rip>, %rax         # <addr>
               	movl	$0x3, %r10d
               	jmpq	*%rax
               	xorl	%eax, %eax
               	retq
               	movl	$0x1, %eax
               	retq

<vla_goto>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x9, %eax
               	movq	%rax, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rax
               	subq	%r11, %rax
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%rax, %rsp
               	movb	$0x9, (%rax)
               	movb	$0x7, 0x8(%rax)
               	movl	$0x7, %r10d
               	testl	%r10d, %r10d
               	jne	<addr>
               	movsbq	(%rax), %rax
               	leaq	-0x10(%rbp), %rsp
               	leave
               	retq
               	movsbq	(%rax), %rcx
               	movsbq	0x8(%rax), %rax
               	addq	%rcx, %rax
               	leaq	-0x10(%rbp), %rsp
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x2, %r10d
               	testl	%r10d, %r10d
               	jne	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	xorl	%r10d, %r10d
               	testl	%r10d, %r10d
               	jne	<addr>
               	movl	$0x3, %edi
               	callq	<addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	xorl	%r10d, %r10d
               	testl	%r10d, %r10d
               	jne	<addr>
               	movl	$0x1, %r10d
               	testl	%r10d, %r10d
               	jne	<addr>
               	movl	$0x9, %edi
               	callq	<addr>
               	cmpl	$0x10, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	leaq	-0x10(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	$0x4, (%rax)
               	movq	$0x2, 0x8(%rax)
               	testb	$0xf, %al
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movq	(%rax), %rax
               	movslq	%eax, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	addq	%rcx, %rax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	$0x0, (%rax)
               	movq	$0x2, 0x8(%rax)
               	xorl	%r10d, %r10d
               	testl	%r10d, %r10d
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	addq	%rcx, %rax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	movl	$0x6, %r10d
               	movl	%r10d, %eax
               	movslq	%eax, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	cmpl	$0x8, %eax
               	jne	<addr>
               	xorl	%r10d, %r10d
               	movl	%r10d, %eax
               	movslq	%eax, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movl	$0x2a, %eax
               	leave
               	retq
               	addq	$0x2, %rax
               	jmp	<addr>
               	addq	$0x2, %rax
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	movq	%rcx, %rax
               	subq	%rdx, %rax
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	movq	%rcx, %rax
               	subq	%rdx, %rax
               	jmp	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
