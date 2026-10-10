
zero_fill_narrow_member_guard.x64:	file format elf64-x86-64

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

<reader>:
               	xorl	%ecx, %ecx
               	movl	$0x2, %eax
               	leaq	<rip>, %rdx      # <addr>
               	movl	(%rdx), %r8d
               	leaq	<rip>, %r9       # <addr>
               	leaq	<rip>, %rsi      # <addr>
               	movq	%rcx, %rdi
               	movl	(%rsi), %edi
               	incq	%rdi
               	movl	%edi, (%rsi)
               	movl	(%r9), %edi
               	cmpl	$0x2, %eax
               	jb	<addr>
               	movl	(%rdx), %eax
               	testb	$0x1, %al
               	jne	<addr>
               	movl	(%rdx), %eax
               	cmpl	%r8d, %eax
               	jne	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	movq	%rcx, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movq	%rdi, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rax      # <addr>
               	movl	$0x2, (%rax)
               	leaq	<rip>, %rax      # <addr>
               	movl	$0x7, (%rax)
               	leaq	<rip>, %rax      # <addr>
               	movl	$0x0, (%rax)
               	callq	<addr>
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %ecx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx      # <addr>
               	movl	$0x3, (%rcx)
               	leaq	<rip>, %rcx      # <addr>
               	movl	$0x9, (%rcx)
               	movl	$0x0, (%rax)
               	callq	<addr>
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %eax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax      # <addr>
               	cmpl	$0x0, (%rax)
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
