
fn_ptr_decay_inside_block.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movslq	%edi, %rdi
               	addq	$0x64, %rdi
               	movslq	%edi, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	xorq	%r12, %r12
               	movl	$0x1, %eax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-<rip>, %rcx       # <addr>
               	jmp	<addr>
               	leaq	-<rip>, %rbx       # <addr>
               	movl	$0x1, %edi
               	movq	%rbx, %r11
               	callq	*%r11
               	addq	%rax, %r12
               	movslq	%r12d, %r12
               	movl	$0x2, %edi
               	movq	%rbx, %r11
               	callq	*%r11
               	addq	%rax, %r12
               	jmp	<addr>
               	cmpq	$0x0, %rcx
               	je	<addr>
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movslq	%r12d, %r12
               	movl	$0x3, %edi
               	movq	%rcx, %r11
               	callq	*%r11
               	addq	%rax, %r12
               	jmp	<addr>
               	leaq	-<rip>, %rax       # <addr>
               	movq	%rax, -0x48(%rbp)
               	movslq	%r12d, %rbx
               	leaq	-0x48(%rbp), %rax
               	movq	(%rax), %rax
               	movl	$0x4, %edi
               	movq	%rax, %r11
               	callq	*%r11
               	addq	%rax, %rbx
               	movslq	%ebx, %rax
               	cmpq	$0x19a, %rax            # imm = 0x19A
               	jne	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x2, %ecx
               	jmp	<addr>
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
