
struct_linked_list.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400287 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe51(%rip)           # 0x4100d8
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	xorq	%r11, %r11
               	movq	%r11, -0x8(%rbp)
               	movl	%r11d, -0x20(%rbp)
               	jmp	0x4002a6 <.text+0x36>
               	movslq	-0x20(%rbp), %r11
               	cmpq	$0x5, %r11
               	jge	0x40030e <.text+0x9e>
               	jmp	0x4002d2 <.text+0x62>
               	leaq	-0x20(%rbp), %r9
               	movslq	(%r9), %r11
               	addq	$0x1, %r11
               	movl	%r11d, (%r9)
               	jmp	0x4002a6 <.text+0x36>
               	movl	$0x10, %ebx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x4004b7 <malloc>
               	movq	%rax, -0x10(%rbp)
               	movq	-0x10(%rbp), %rbx
               	movslq	-0x20(%rbp), %rax
               	movl	%eax, (%rbx)
               	movq	-0x10(%rbp), %r9
               	addq	$0x8, %r9
               	movq	-0x8(%rbp), %rax
               	movq	%rax, (%r9)
               	movq	-0x10(%rbp), %rbx
               	movq	%rbx, -0x8(%rbp)
               	jmp	0x4002bc <.text+0x4c>
               	xorq	%rbx, %rbx
               	movl	%ebx, -0x18(%rbp)
               	movq	-0x8(%rbp), %rax
               	movq	%rax, -0x10(%rbp)
               	jmp	0x400321 <.text+0xb1>
               	movq	-0x10(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	0x400359 <.text+0xe9>
               	movslq	-0x18(%rbp), %rbx
               	movq	-0x10(%rbp), %rax
               	movslq	(%rax), %r9
               	addq	%r9, %rbx
               	movslq	%ebx, %rbx
               	movl	%ebx, -0x18(%rbp)
               	addq	$0x8, %rax
               	movq	(%rax), %r9
               	movq	%r9, -0x10(%rbp)
               	jmp	0x400321 <.text+0xb1>
               	movslq	-0x18(%rbp), %r9
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
