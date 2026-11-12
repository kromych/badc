
over_aligned_local_in_an_inlined_function.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	andq	$-0x40, %rsp
               	leaq	0x20(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movl	$0x0, (%rsp)
               	movl	$0x1, 0x4(%rsp)
               	movl	$0x2, 0x8(%rsp)
               	movl	$0x3, 0xc(%rsp)
               	movl	$0x4, 0x10(%rsp)
               	movl	$0x5, 0x14(%rsp)
               	movl	$0x6, 0x18(%rsp)
               	leaq	(%rsp), %rax
               	movl	$0x7, 0x1c(%rsp)
               	movl	$0x3e8, %ecx            # imm = 0x3E8
               	xorl	%edx, %edx
               	testb	$0x1f, %al
               	cmoveq	%rdx, %rcx
               	movl	0x4(%rsp), %eax
               	addq	%rcx, %rax
               	movl	0x8(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	0xc(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	0x10(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	0x14(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	0x18(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	0x1c(%rsp), %ecx
               	leaq	(%rax,%rcx), %rsi
               	leaq	(%rsp), %rdi
               	xorl	%eax, %eax
               	movb	%al, (%rsp)
               	movb	$0x1, 0x1(%rsp)
               	movb	$0x2, 0x2(%rsp)
               	movl	$0x3e8, %r8d            # imm = 0x3E8
               	testb	$0x3f, %dil
               	cmovneq	%r8, %rax
               	movsbq	0x1(%rsp), %rdi
               	addq	%rdi, %rax
               	movsbq	0x2(%rsp), %rdi
               	addq	%rdi, %rax
               	addq	%rax, %rsi
               	movl	$0x1, (%rsp)
               	movl	$0x2, 0x4(%rsp)
               	movl	$0x3, 0x8(%rsp)
               	movl	$0x4, 0xc(%rsp)
               	leaq	(%rsp), %rax
               	movl	$0x5, 0x10(%rsp)
               	movl	$0x6, 0x14(%rsp)
               	movl	$0x7, 0x18(%rsp)
               	movl	$0x8, 0x1c(%rsp)
               	movl	$0x3e8, %ecx            # imm = 0x3E8
               	xorl	%edx, %edx
               	testb	$0x1f, %al
               	cmoveq	%rdx, %rcx
               	movl	(%rsp), %eax
               	addq	%rcx, %rax
               	movl	0x4(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	0x8(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	0xc(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	0x10(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	0x14(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	0x18(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	0x1c(%rsp), %ecx
               	addq	%rax, %rcx
               	leaq	(%rsp), %rdx
               	movb	$0x1, (%rsp)
               	movb	$0x1, 0x1(%rsp)
               	movb	$0x2, 0x2(%rsp)
               	movl	$0x3e8, %edi            # imm = 0x3E8
               	xorl	%r8d, %r8d
               	testb	$0x3f, %dl
               	cmoveq	%r8, %rdi
               	movsbq	(%rsp), %rdx
               	addq	%rdi, %rdx
               	movsbq	0x1(%rsp), %rdi
               	addq	%rdi, %rdx
               	movsbq	0x2(%rsp), %rdi
               	addq	%rdi, %rdx
               	addq	%rdx, %rcx
               	addq	%rsi, %rcx
               	movl	$0x2, (%rsp)
               	movl	$0x3, 0x4(%rsp)
               	movl	$0x4, 0x8(%rsp)
               	movl	$0x5, 0xc(%rsp)
               	movl	$0x6, 0x10(%rsp)
               	leaq	(%rsp), %rax
               	movl	$0x7, 0x14(%rsp)
               	movl	$0x8, 0x18(%rsp)
               	movl	$0x9, 0x1c(%rsp)
               	movl	$0x3e8, %edx            # imm = 0x3E8
               	xorl	%esi, %esi
               	testb	$0x1f, %al
               	cmoveq	%rsi, %rdx
               	movl	(%rsp), %eax
               	addq	%rdx, %rax
               	movl	0x4(%rsp), %edx
               	addq	%rdx, %rax
               	movl	0x8(%rsp), %edx
               	addq	%rdx, %rax
               	movl	0xc(%rsp), %edx
               	addq	%rdx, %rax
               	movl	0x10(%rsp), %edx
               	addq	%rdx, %rax
               	movl	0x14(%rsp), %edx
               	addq	%rdx, %rax
               	movl	0x18(%rsp), %edx
               	addq	%rdx, %rax
               	movl	0x1c(%rsp), %edx
               	addq	%rax, %rdx
               	leaq	(%rsp), %rsi
               	movb	$0x2, (%rsp)
               	movb	$0x1, 0x1(%rsp)
               	movb	$0x2, 0x2(%rsp)
               	movl	$0x3e8, %eax            # imm = 0x3E8
               	xorl	%edi, %edi
               	testb	$0x3f, %sil
               	cmoveq	%rdi, %rax
               	movsbq	(%rsp), %rsi
               	addq	%rsi, %rax
               	movsbq	0x1(%rsp), %rsi
               	addq	%rsi, %rax
               	movsbq	0x2(%rsp), %rsi
               	addq	%rsi, %rax
               	addq	%rdx, %rax
               	addq	%rcx, %rax
               	cmpl	$0x78, %eax
               	jne	<addr>
               	leaq	0x20(%rsp), %rax
               	testb	$0xf, %al
               	jne	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
