
struct_arg_two_eightbyte.x64:	file format elf64-x86-64

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
               	movl	$0x1111, %eax           # imm = 0x1111
               	movl	$0x2222, %ecx           # imm = 0x2222
               	leaq	<rip>, %rdx
               	movl	$0x9, %esi
               	movl	%esi, (%rdx)
               	leaq	<rip>, %rdx
               	movq	%rax, (%rdx)
               	leaq	<rip>, %rdx
               	movl	$0x4, %esi
               	movl	%esi, (%rdx)
               	leaq	<rip>, %rdx
               	movq	%rcx, (%rdx)
               	leaq	<rip>, %rdx
               	movl	$0x6, %edi
               	movl	%edi, (%rdx)
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rdx
               	cmpl	$0x9, %edx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	cmpq	$0x1111, %rdx           # imm = 0x1111
               	jne	<addr>
               	leaq	<rip>, %rdx
               	movl	(%rdx), %edx
               	xorq	$0x4, %rdx
               	movl	%edx, %edx
               	testl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	cmpq	$0x2222, %rdx           # imm = 0x2222
               	jne	<addr>
               	leaq	<rip>, %rdx
               	movl	(%rdx), %edx
               	xorq	$0x6, %rdx
               	movl	%edx, %edx
               	testl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rdx
               	movq	%rax, (%rdx)
               	leaq	<rip>, %rax
               	movl	%esi, (%rax)
               	leaq	<rip>, %rax
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	%edi, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x1111, %rax           # imm = 0x1111
               	jne	<addr>
               	leaq	<rip>, %rax
               	movl	(%rax), %eax
               	xorq	$0x4, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x2222, %rax           # imm = 0x2222
               	jne	<addr>
               	leaq	<rip>, %rax
               	movl	(%rax), %eax
               	xorq	$0x6, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	xorq	%rax, %rax
               	retq
