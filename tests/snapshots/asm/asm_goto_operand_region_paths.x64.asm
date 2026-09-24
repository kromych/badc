
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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	leaq	<rip>, %rax         # <addr>
               	movq	%rax, %rbx
               	movl	$0x3, %eax
               	jmpq	*%rbx
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq

<vla_goto>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x9, %eax
               	movq	%rax, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rcx
               	subq	%r11, %rcx
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%rcx, %rsp
               	movb	$0x9, (%rcx)
               	movb	$0x7, 0x8(%rcx)
               	movl	$0x7, %eax
               	testl	%eax, %eax
               	jne	<addr>
               	movsbq	(%rcx), %rax
               	leaq	-0x10(%rbp), %rsp
               	leave
               	retq
               	movsbq	(%rcx), %rax
               	movsbq	0x8(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	-0x10(%rbp), %rsp
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x28, %rsp
               	pushq	%rbx
               	movl	$0x2, %eax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x3, %edi
               	callq	<addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x1, %eax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x9, %edi
               	callq	<addr>
               	cmpl	$0x10, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x20(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	$0x4, (%rax)
               	movq	$0x2, 0x8(%rax)
               	testb	$0xf, %al
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	(%rax), %rax
               	movslq	%eax, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	addq	%rcx, %rax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	leaq	-0x20(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	$0x0, (%rax)
               	movq	$0x2, 0x8(%rax)
               	xorl	%eax, %eax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	addq	%rcx, %rax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	movl	$0x6, %ebx
               	movl	%ebx, %eax
               	movq	%rax, %rcx
               	movslq	%ecx, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	cmpl	$0x8, %ecx
               	jne	<addr>
               	xorl	%ebx, %ebx
               	movl	%ebx, %eax
               	movq	%rax, %rcx
               	movslq	%ecx, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2a, %eax
               	popq	%rbx
               	leave
               	retq
               	addq	$0x2, %rcx
               	jmp	<addr>
               	addq	$0x2, %rcx
               	jmp	<addr>
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	movq	%rcx, %rax
               	subq	%rdx, %rax
               	jmp	<addr>
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	movq	%rcx, %rax
               	subq	%rdx, %rax
               	jmp	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
