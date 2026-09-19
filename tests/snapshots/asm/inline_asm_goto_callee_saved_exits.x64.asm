
inline_asm_goto_callee_saved_exits.x64:	file format elf64-x86-64

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

<leaves_by_patched_branch>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x28, %rsp
               	pushq	%rbx
               	movq	%rdi, -0x20(%rbp)
               	leaq	<rip>, %rax        # <addr>
               	movq	%rax, -0x8(%rbp)
               	movq	%rax, %rcx
               	movq	%rdi, %rax
               	movq	$0x0, %rbx
               	jmpq	*%rcx
               	jmp	<addr>
               	movq	-0x20(%rbp), %rax
               	incq	%rax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	pushq	%r12
               	pushq	%rbx
               	movq	$0x0, -0x8(%rbp)
               	movl	$0x6, %edi
               	callq	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movq	$0x65, %rbx
               	movq	$0x6, %rdi
               	callq	<addr>
               	addq	%rbx, %rax
               	movq	%rax, %r12
               	movq	%r12, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x6c, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x2a, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
