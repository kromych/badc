
local_array_partial_init_zero.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xb0, %rsp
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movslq	%ecx, %rax
               	cmpq	$0x28, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rcx
               	addq	$0x1, %rcx
               	jmp	<addr>
               	leaq	-0xa0(%rbp), %rax
               	movslq	%ecx, %rdx
               	movl	%edi, %esi
               	movl	%esi, (%rax,%rdx,4)
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	leaq	-0x68(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	movq	0x8(%rcx), %r11
               	movq	%r11, 0x8(%rax)
               	movq	0x10(%rcx), %r11
               	movq	%r11, 0x10(%rax)
               	movq	0x18(%rcx), %r11
               	movq	%r11, 0x18(%rax)
               	movq	0x20(%rcx), %r11
               	movq	%r11, 0x20(%rax)
               	movq	0x28(%rcx), %r11
               	movq	%r11, 0x28(%rax)
               	movq	0x30(%rcx), %r11
               	movq	%r11, 0x30(%rax)
               	movq	0x38(%rcx), %r11
               	movq	%r11, 0x38(%rax)
               	movq	0x40(%rcx), %r11
               	movq	%r11, 0x40(%rax)
               	movq	0x48(%rcx), %r11
               	movq	%r11, 0x48(%rax)
               	movq	0x50(%rcx), %r11
               	movq	%r11, 0x50(%rax)
               	movq	0x58(%rcx), %r11
               	movq	%r11, 0x58(%rax)
               	movzbq	0x60(%rcx), %r11
               	movb	%r11b, 0x60(%rax)
               	movzbq	0x61(%rcx), %r11
               	movb	%r11b, 0x61(%rax)
               	movzbq	0x62(%rcx), %r11
               	movb	%r11b, 0x62(%rax)
               	movzbq	0x63(%rcx), %r11
               	movb	%r11b, 0x63(%rax)
               	popq	%r11
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movslq	%ecx, %rdx
               	cmpq	$0x19, %rdx
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rcx
               	addq	$0x1, %rcx
               	jmp	<addr>
               	movl	%eax, %eax
               	leaq	-0x68(%rbp), %rdx
               	movslq	%ecx, %rsi
               	movl	(%rdx,%rsi,4), %edx
               	addq	%rdx, %rax
               	jmp	<addr>
               	movl	%eax, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0xdeadbeef, %edi       # imm = 0xDEADBEEF
               	callq	<addr>
               	callq	<addr>
               	movq	%rax, %rbx
               	movl	$0x12345678, %edi       # imm = 0x12345678
               	callq	<addr>
               	callq	<addr>
               	movq	%rax, %rcx
               	movl	%ebx, %ebx
               	cmpq	$0x0, %rbx
               	je	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	%ecx, %ecx
               	cmpq	$0x0, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
