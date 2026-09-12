
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
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	movl	%edi, -0x20(%rbp)
               	leaq	<rip>, %rax        # <addr>
               	movq	%rax, -0x8(%rbp)
               	movslq	%edi, %rcx
               	movq	%rax, %rbx
               	movq	%rcx, %rax
               	jmpq	*%rbx
               	jmp	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
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
               	movl	$0x9, %eax
               	movb	%al, (%rcx)
               	movl	$0x7, %eax
               	movb	%al, 0x8(%rcx)
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
               	movslq	%eax, %rax
               	leaq	-0x10(%rbp), %rsp
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0x2, %eax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x7, %eax
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	xorq	%rax, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x1, %eax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x3, %edi
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	xorq	%rax, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x1, %eax
               	testl	%eax, %eax
               	jne	<addr>
               	xorq	%rax, %rax
               	movl	$0x9, %edi
               	callq	<addr>
               	cmpq	$0x10, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x4, %ecx
               	leaq	-0x30(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rcx, (%rax)
               	movl	$0x2, %ecx
               	movq	%rcx, 0x8(%rax)
               	movq	%rax, %rcx
               	andq	$0xf, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movabsq	$-0x64, %rax
               	cmpq	$0x2, %rax
               	jne	<addr>
               	xorq	%rcx, %rcx
               	leaq	-0x30(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rcx, (%rax)
               	movl	$0x2, %ecx
               	movq	%rcx, 0x8(%rax)
               	andq	$0xf, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movabsq	$-0x64, %rax
               	cmpq	$0x2, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	xorq	%rax, %rax
               	movl	%eax, -0x18(%rbp)
               	movl	$0x6, %ebx
               	movl	%ebx, %eax
               	movl	%eax, -0x18(%rbp)
               	movslq	-0x18(%rbp), %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movslq	-0x18(%rbp), %rax
               	cmpq	$0x8, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	movl	%eax, -0x18(%rbp)
               	xorq	%rbx, %rbx
               	movl	%ebx, %eax
               	movl	%eax, -0x18(%rbp)
               	movslq	-0x18(%rbp), %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movslq	-0x18(%rbp), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x2a, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movslq	-0x18(%rbp), %rax
               	addq	$0x2, %rax
               	movslq	%eax, %rax
               	jmp	<addr>
               	movslq	-0x18(%rbp), %rax
               	addq	$0x2, %rax
               	movslq	%eax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	-0x30(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	jmp	<addr>
               	leaq	-0x30(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	subq	%r10, %rax
               	movslq	%eax, %rax
               	jmp	<addr>
               	movq	(%rax), %rax
               	movslq	%eax, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	-0x30(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	jmp	<addr>
               	leaq	-0x30(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	subq	%r10, %rax
               	movslq	%eax, %rax
               	jmp	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	movl	$0x8, %eax
               	jmp	<addr>
