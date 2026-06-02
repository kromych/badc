
call_indirect_target_scratch_collision.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movslq	%edi, %rbx
               	leaq	<rip>, %r12
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r12, %r8
               	movq	(%r8), %r8
               	cmpq	$0x0, %r8
               	je	<addr>
               	movq	%rbx, %rdi
               	shlq	$0x3, %rdi
               	addq	%r12, %rdi
               	movq	(%rdi), %rdi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r8
               	xorq	%rdi, %rdi
               	leaq	<rip>, %rsi
               	movq	%rsi, (%r8)
               	leaq	-0x18(%rbp), %rdx
               	addq	$0x8, %rdx
               	leaq	<rip>, %rsi
               	movq	%rsi, (%rdx)
               	leaq	-0x18(%rbp), %r8
               	addq	$0x10, %r8
               	leaq	<rip>, %rsi
               	movq	%rsi, (%r8)
               	leaq	-0x18(%rbp), %rdx
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rdx
               	movq	(%rdx), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	addq	%r12, %rsi
               	movq	(%rax), %rax
               	movq	%rax, (%rsi)
               	jmp	<addr>
               	shlq	$0x3, %rbx
               	addq	%rbx, %r12
               	movq	(%r12), %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movslq	%ecx, %rcx
               	xorq	%rax, %rax
               	movzbq	(%rsi), %rsi
               	addq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	movl	%ecx, (%r8)
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movslq	%ecx, %rcx
               	movq	(%rdi), %r9
               	movq	%rcx, %r11
               	andq	$0xffff, %r11           # imm = 0xFFFF
               	movq	%r9, %r10
               	movq	%r11, %rcx
               	callq	*%r10
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movq	%rbx, (%rsp)
               	leaq	-0x8(%rbp), %r11
               	leaq	-<rip>, %r9        # <addr>
               	movq	%r9, (%r11)
               	xorq	%rdx, %rdx
               	movl	%edx, -0x10(%rbp)
               	leaq	-0x8(%rbp), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x1ffff, %ecx          # imm = 0x1FFFF
               	leaq	-0x10(%rbp), %r8
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	<rip>, %rdi
               	movslq	%ebx, %rsi
               	movslq	-0x10(%rbp), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movslq	%ebx, %rbx
               	cmpq	$0x0, %rbx
               	sete	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0x48(%rbp)
               	cmpq	$0x0, %rbx
               	je	<addr>
               	movslq	-0x10(%rbp), %rax
               	cmpq	$0x10040, %rax          # imm = 0x10040
               	sete	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x48(%rbp)
               	jmp	<addr>
               	movq	-0x48(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	xorq	%rbx, %rbx
               	movq	%rbx, -0x50(%rbp)
               	jmp	<addr>
               	movl	$0x1, %ebx
               	movq	%rbx, -0x50(%rbp)
               	jmp	<addr>
               	movq	-0x50(%rbp), %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
