
alloca_arena_in_bounds.x64:	file format elf64-x86-64

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
               	subq	$0x18, %rsp
               	pushq	%rbx
               	movl	$0x1f40, %edx           # imm = 0x1F40
               	movq	%rdx, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rbx
               	subq	%r11, %rbx
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%rbx, %rsp
               	movl	$0x3, %esi
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	cmpl	$0x1f40, %eax           # imm = 0x1F40
               	jge	<addr>
               	movzbq	(%rbx,%rax), %rdx
               	addq	%rdx, %rcx
               	incq	%rax
               	cmpl	$0x1f40, %eax           # imm = 0x1F40
               	jl	<addr>
               	cmpl	$0x5dc0, %ecx           # imm = 0x5DC0
               	jne	<addr>
               	xorl	%eax, %eax
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
