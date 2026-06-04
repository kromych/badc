
fn_ptr_decay_inside_block.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movq	%rdi, %rax
               	movslq	%eax, %rax
               	addq	$0x64, %rax
               	movslq	%eax, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	xorq	%rax, %rax
               	movl	%eax, -0x8(%rbp)
               	movl	$0x1, %eax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	-<rip>, %rbx       # <addr>
               	jmp	<addr>
               	leaq	-<rip>, %rbx       # <addr>
               	leaq	-0x8(%rbp), %r12
               	movslq	(%r12), %r14
               	movl	$0x1, %edi
               	movq	%rbx, %r11
               	callq	*%r11
               	addq	%r14, %rax
               	movl	%eax, (%r12)
               	leaq	-0x8(%rbp), %r12
               	movslq	(%r12), %r14
               	movl	$0x2, %edi
               	movq	%rbx, %r11
               	callq	*%r11
               	addq	%r14, %rax
               	movl	%eax, (%r12)
               	jmp	<addr>
               	cmpq	$0x0, %rbx
               	je	<addr>
               	jmp	<addr>
               	xorq	%rbx, %rbx
               	jmp	<addr>
               	leaq	-0x8(%rbp), %r12
               	movslq	(%r12), %r14
               	movl	$0x3, %edi
               	movq	%rbx, %r11
               	callq	*%r11
               	addq	%r14, %rax
               	movl	%eax, (%r12)
               	jmp	<addr>
               	leaq	-<rip>, %rax       # <addr>
               	movq	%rax, -0x48(%rbp)
               	leaq	-0x8(%rbp), %rbx
               	movslq	(%rbx), %r12
               	leaq	-0x48(%rbp), %rax
               	movq	(%rax), %rax
               	movl	$0x4, %edi
               	movq	%rax, %r11
               	callq	*%r11
               	addq	%r12, %rax
               	movl	%eax, (%rbx)
               	movslq	-0x8(%rbp), %rax
               	cmpq	$0x19a, %rax            # imm = 0x19A
               	jne	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x2, %ecx
               	jmp	<addr>
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
