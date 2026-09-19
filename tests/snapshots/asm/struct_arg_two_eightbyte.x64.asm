
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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movl	$0x1111, %eax           # imm = 0x1111
               	movl	$0x2222, %ecx           # imm = 0x2222
               	leaq	<rip>, %rdx
               	movl	$0x9, %esi
               	movl	%esi, (%rdx)
               	leaq	<rip>, %rdx
               	movq	%rax, (%rdx)
               	leaq	<rip>, %rsi
               	movl	$0x4, %edi
               	movl	%edi, (%rsi)
               	leaq	<rip>, %r8
               	movq	%rcx, (%r8)
               	leaq	<rip>, %r9
               	movl	$0x6, %ebx
               	movl	%ebx, (%r9)
               	leaq	<rip>, %rbx
               	movslq	(%rbx), %rbx
               	cmpl	$0x9, %ebx
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	(%rdx), %rdx
               	cmpq	$0x1111, %rdx           # imm = 0x1111
               	jne	<addr>
               	movl	(%rsi), %edx
               	xorq	$0x4, %rdx
               	testl	%edx, %edx
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	(%r8), %rdx
               	cmpq	$0x2222, %rdx           # imm = 0x2222
               	jne	<addr>
               	movl	(%r9), %edx
               	xorq	$0x6, %rdx
               	testl	%edx, %edx
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdx
               	movq	%rax, (%rdx)
               	leaq	<rip>, %rax
               	movl	%edi, (%rax)
               	leaq	<rip>, %rax
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x6, %ecx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x1111, %rax           # imm = 0x1111
               	jne	<addr>
               	leaq	<rip>, %rax
               	movl	(%rax), %eax
               	xorq	$0x4, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x2222, %rax           # imm = 0x2222
               	jne	<addr>
               	leaq	<rip>, %rax
               	movl	(%rax), %eax
               	xorq	$0x6, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
