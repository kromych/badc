
mixed_sign_word_equality.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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

<u>:
               	movq	%rdi, %rax
               	retq

<s>:
               	movq	%rdi, %rax
               	retq

<main>:
               	pushq	%rax
               	pushq	%r12
               	pushq	%rbx
               	xorl	%ebx, %ebx
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax,%rbx,4), %edi
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax,%rbx,4), %edi
               	callq	<addr>
               	cmpl	$0x51, %r12d
               	sete	%sil
               	movzbq	%sil, %rsi
               	leaq	<rip>, %rdx # <addr>
               	movl	(%rdx,%rbx,4), %ecx
               	cmpl	$0x51, %ecx
               	sete	%dil
               	movzbq	%dil, %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	cmpl	$-0x1, %r12d
               	sete	%sil
               	movzbq	%sil, %rsi
               	cmpl	$-0x1, %ecx
               	sete	%dil
               	movzbq	%dil, %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	cmpl	$-0x1, %eax
               	sete	%sil
               	movzbq	%sil, %rsi
               	cmpl	$-0x1, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	cmpl	%ecx, %esi
               	jne	<addr>
               	cmpl	%eax, %r12d
               	jne	<addr>
               	cmpl	$0x80000000, %eax       # imm = 0x80000000
               	sete	%cl
               	movzbq	%cl, %rcx
               	movl	(%rdx,%rbx,4), %eax
               	cmpl	$0x80000000, %eax       # imm = 0x80000000
               	sete	%dl
               	movzbq	%dl, %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	cmpl	$0x80000000, %r12d      # imm = 0x80000000
               	sete	%cl
               	movzbq	%cl, %rcx
               	cmpl	$0x80000000, %eax       # imm = 0x80000000
               	sete	%al
               	movzbq	%al, %rax
               	cmpl	%eax, %ecx
               	jne	<addr>
               	incq	%rbx
               	nopw	(%rax,%rax)
               	cmpl	$0x6, %ebx
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r11
               	retq
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r11
               	retq
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r11
               	retq
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r11
               	retq
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r11
               	retq
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r11
               	retq
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r11
               	retq
