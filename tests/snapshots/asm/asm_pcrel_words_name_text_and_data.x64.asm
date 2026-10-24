
asm_pcrel_words_name_text_and_data.x64:	file format elf64-x86-64

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

<fn>:
               	movl	$0x3, %eax
               	retq

<main>:
               	leaq	<rip>, %rax       # <addr>
               	leaq	<rip>, %rdx      # <addr>
               	movslq	(%rax), %rsi
               	leaq	-<rip>, %rcx       # <addr>
               	addq	%rax, %rsi
               	subq	%rcx, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	je	<addr>
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movslq	(%rax), %rdx
               	addq	%rax, %rdx
               	subq	%rcx, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	je	<addr>
               	addq	$0x4, %rax
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %eax
               	addq	$0x3, %rax
               	cmpl	$0x7, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	retq
               	movl	$0x9, %eax
               	jmp	<addr>
               	leaq	0x4(%rax), %rdx
               	movslq	0x4(%rax), %rsi
               	leaq	<rip>, %rdi      # <addr>
               	addq	%rsi, %rdx
               	subq	%rdi, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	0x8(%rax), %rdx
               	movslq	0x8(%rax), %rsi
               	leaq	0x18(%rax), %rdi
               	addq	%rsi, %rdx
               	subq	%rdi, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	addq	$0x10, %rax
               	movq	(%rax), %rdx
               	addq	%rdx, %rax
               	subq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	leaq	0x4(%rax), %rsi
               	movslq	0x4(%rax), %rdi
               	addq	%rdi, %rsi
               	subq	%rdx, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	0x8(%rax), %rsi
               	movslq	0x8(%rax), %rdi
               	leaq	0x18(%rax), %r8
               	addq	%rdi, %rsi
               	subq	%r8, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	addq	$0x10, %rax
               	movq	(%rax), %rsi
               	addq	%rsi, %rax
               	subq	%rdx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>

<text_tbl>:
               	enter	$-0x2, $-0x1
               	movl	$0x1000001a, %esp       # imm = 0x1000001A
               	addb	%al, (%rax)
               	addb	%al, (%rax)
               	addb	%al, (%rax)
               	addb	%dh, 0x1a(%rax)
               	addb	%al, (%rax)
               	addb	%al, (%rax)

<text_end>:
               	addb	%al, (%rax)
               	addb	%al, (%rax)
